//
//  CBTableView.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBTable.h"

#import "CBSection.h"

@implementation CBTable

@synthesize delegate = _delegate;

@dynamic sections;

- (id) initWithSections:(NSArray*)sections {
	if (self = [super init]) {
		
		_sections = [sections mutableCopy];

	}
	return self;
}
- (id) init {
	if (self = [self initWithSections:[NSArray array]]) {
		
	}
	return self;
}


+ (CBTable*) table {
	CBTable *table = [[CBTable alloc] init];
	return [table autorelease];
}
+ (CBTable*) tableWithSectionArray:(NSArray*)sections {
	CBTable *table = [[CBTable alloc] initWithSections:sections];
	return [table autorelease];
}
+ (CBTable*) tableWithSections:(CBSection*)section, ... {
	CBTable *table = [[CBTable alloc] init];
	
	[table addSection:section];
	
	va_list args;
    va_start(args, section);
	[table addSectionsVargs:args];
	
	return [table autorelease];
}

- (void) dealloc {
	[_sections release];
	
	[super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"CBTable {sections: %@}", _sections];
}

#pragma mark Section access

- (NSUInteger) sectionCount {
	return _sections.count;
}

- (id) sectionAtIndex:(NSUInteger)index {
	return [_sections objectAtIndex:index];
}

- (NSUInteger) indexOfSection:(CBSection*)section {
	return [_sections indexOfObject:section];
}
- (NSUInteger) indexOfSectionWithTag:(NSString*)tag {
    return [self indexOfSection:[self sectionWithTag:tag]];
}

- (id) addSection:(CBSection*)section {
	section.table = self;
	[_sections addObject:section];
	
	if (_delegate && [_delegate respondsToSelector:@selector(table:sectionAdded:)]) {
		[_delegate table:self sectionAdded:section];
	}
	
	return section;
}

- (id) insertSection:(CBSection*)section atIndex:(NSUInteger)index {
	section.table = self;
	[_sections insertObject:section atIndex:index];
	
	if (_delegate && [_delegate respondsToSelector:@selector(table:sectionAdded:)]) {
		[_delegate table:self sectionAdded:section];
	}
	
	return section;
}

- (void) addSections:(CBSection*)section, ... {
	[self addSection:section];
	
	va_list args;
    va_start(args, section);
	[self addSectionsVargs:args];
}

- (void) addSectionsVargs:(va_list)args {
	CBSection *s;
    while ((s = va_arg(args, CBSection *))) {
        [self addSection:s];
    }
	va_end(args);
}

- (void) removeSection:(CBSection*)section {
	int idx = [_sections indexOfObject:section];
	if (idx != NSNotFound) {
		[_sections removeObject:section];
	
		if (_delegate && [_delegate conformsToProtocol:@protocol(CBTableDelegate)]) {
			[_delegate table:self sectionRemovedAtIndex:idx];
		}
	}
}

- (NSArray*) sections {
	return [[_sections copy] autorelease];
}

- (id) sectionWithTag:(NSString*)tag {
    if (!tag || [@"" isEqual:tag]) return nil;
    
    // linear search since we are optimized for a small amount of sections
    for (CBSection *section in _sections) {
        if ([tag isEqual:section.tag]) {
            return section;
        }
    }
    
    return nil;
}
- (id) cellWithTag:(NSString*)tag {
    if (!tag || [@"" isEqual:tag]) return nil;
    
    // linear search since we are optimized for a small amount of sections
    for (CBSection *section in _sections) {
        CBCell *cell = [section cellWithTag:tag];
        
        if (cell) {
            return cell;
        }
    }
    
    return nil;
}

#pragma mark Cell access

- (NSIndexPath*) indexPathOfCell:(CBCell*)cell {
	NSUInteger section = NSNotFound;
	NSUInteger row = NSNotFound;
	
	int s = 0;
	int r;
	for (CBSection *sect in _sections) {
		if ((r = [sect indexOfCell:cell]) != NSNotFound) {
			row = r;
			section = s;
		}
		s++;
	}
	if (section != NSNotFound && row != NSNotFound) {
		return [NSIndexPath indexPathForRow:row inSection:section];
	} else {
		return NULL;
	}
}
- (NSIndexPath*) indexPathOfCellWithTag:(NSString*)cellTag;
{
    return [self indexPathOfCell:[self cellWithTag:cellTag]];
}
- (CBCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CBSection *sect = [self sectionAtIndex:indexPath.section];
	return [sect cellAtIndex:indexPath.row];
}

@end
