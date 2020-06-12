//
//  CBTableView.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBTable.h"

#import "CBSection.h"
#import "CBCell.h"

@interface CBCell ()
@property (nonatomic, assign, getter=isHidden) BOOL hidden;
@end


@implementation CBTable

@synthesize delegate = _delegate;

@dynamic sections;

- (instancetype) initWithSections:(NSArray*)sections {
	self = [super init];
    if (!self) return nil;
    
    _sections = [sections mutableCopy];
    for (CBSection *section in _sections) {
        section.table = self;
    }

	return self;
}
- (instancetype) init
{
	return [self initWithSections:[NSArray array]];
}


+ (CBTable*) table {
	CBTable *table = [[CBTable alloc] init];
	return table;
}
+ (CBTable*) tableWithSectionArray:(NSArray*)sections {
	CBTable *table = [[CBTable alloc] initWithSections:sections];
	return table;
}
+ (CBTable*) tableWithSections:(CBSection*)section, ... {
	CBTable *table = [[CBTable alloc] init];
	
	[table addSection:section];
	
	va_list args;
    va_start(args, section);
	[table addSectionsVargs:args];
	
	return table;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"CBTable {sections: %@}", _sections];
}

- (void) setEnabled:(BOOL)enabled {
    for (CBSection *section in self.sections) {
        for (CBCell *cell in section.cells) {
            [cell setEnabled:enabled];
        }
    }
}

#pragma mark Section access

- (NSArray*) visibleSections
{
    static NSPredicate *_predicate;
    if (!_predicate) {
        _predicate = [NSPredicate predicateWithFormat:@"hidden == NO"];
    }
    
    return [_sections filteredArrayUsingPredicate:_predicate];
}

- (NSUInteger) sectionCount {
	return [self visibleSections].count;
}

- (CBSection*) sectionAtIndex:(NSUInteger)index {
	return [[self visibleSections] objectAtIndex:index];
}

- (NSUInteger) indexOfSection:(CBSection*)section {
	return [[self visibleSections] indexOfObject:section];
}
- (NSUInteger) indexOfSectionWithTag:(NSString*)tag {
    return [self indexOfSection:[self sectionWithTag:tag]];
}

- (CBSection*) addSection:(CBSection*)section
{
	section.table = self;
	[_sections addObject:section];
	
	if (_delegate && [_delegate respondsToSelector:@selector(table:sectionAdded:)]) {
		[_delegate table:self sectionAdded:section];
	}
	
	return section;
}

- (CBSection*) insertSection:(CBSection*)section atIndex:(NSUInteger)index
{
	section.table = self;
	[_sections insertObject:section atIndex:index];
	
	if (_delegate && [_delegate respondsToSelector:@selector(table:sectionAdded:)]) {
		[_delegate table:self sectionAdded:section];
	}
	
	return section;
}

- (void) addSections:(CBSection*)section, ...
{
	[self addSection:section];
	
	va_list args;
    va_start(args, section);
	[self addSectionsVargs:args];
}
- (void) addSectionsArray:(NSArray<CBSection*>*)sections
{
    for (CBSection *section in sections) {
        section.table = self;
        [_sections addObject:section];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(table:sectionsAdded:)]) {
        [_delegate table:self sectionsAdded:sections];
    }
}

- (void) addSectionsVargs:(va_list)args {
	CBSection *s;
    while ((s = va_arg(args, CBSection *))) {
        [self addSection:s];
    }
	va_end(args);
}

- (void) removeSection:(CBSection*)section {
	NSUInteger idx = [_sections indexOfObject:section];
	if (idx != NSNotFound) {
		[_sections removeObject:section];
	
		if (_delegate && [_delegate conformsToProtocol:@protocol(CBTableDelegate)]) {
			[_delegate table:self sectionRemovedAtIndex:idx];
		}
	}
}

- (NSArray*) sections {
	return [_sections copy];
}

- (CBSection*) sectionWithTag:(NSString*)tag {
    if (!tag || [@"" isEqual:tag]) return nil;
    
    static NSPredicate *_predicate;
    if (!_predicate) _predicate = [NSPredicate predicateWithFormat:@"tag == $TAG"];
    
    NSArray *result = [_sections filteredArrayUsingPredicate:[_predicate predicateWithSubstitutionVariables:@{@"TAG": tag}]];
    
    return result.count == 0 ? nil : [result objectAtIndex:0];
}
- (CBCell*) cellWithTag:(NSString*)tag {
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
- (CBCell*) cellWithValueKeyPath:(NSString*)valuePath {
    if (!valuePath || [@"" isEqual:valuePath]) return nil;
    
    // linear search since we are optimized for a small amount of sections
    for (CBSection *section in _sections) {
        CBCell *cell = [section cellWithValueKeyPath:valuePath];
        
        if (cell) {
            return cell;
        }
    }
    
    return nil;
}

#pragma mark Cell access

- (NSIndexPath*) indexPathOfCell:(CBCell*)cell
{
    NSUInteger section = 0;
    NSUInteger row;
    for (CBSection *sect in [self visibleSections]) {
        if ((row = [sect indexOfCell:cell]) != NSNotFound) {
            return [NSIndexPath indexPathForRow:row inSection:section];
        }
        section++;
    }
    return nil;
}
- (NSIndexPath*) indexPathOfCellWithTag:(NSString*)cellTag;
{
    return [self indexPathOfCell:[self cellWithTag:cellTag]];
}
- (CBCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CBSection *sect = [self sectionAtIndex:indexPath.section];
	return [sect cellAtIndex:indexPath.row];
}

- (CBCell*) visibleCellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    CBSection *sect = [self sectionAtIndex:indexPath.section];
    return [sect visibleCellAtIndex:indexPath.row];
}

- (void) setCell:(CBCell*)cell hidden:(BOOL)hidden
{
    if (hidden == cell.hidden) { return; }
    if (hidden) {
        NSIndexPath *indexPath = [self indexPathOfCell:cell];
        CBSection *section = [self sectionAtIndex:indexPath.section];
        cell.hidden = hidden;
        [(id<CBTableDelegate>)self.delegate table:self
                                          section:section
                           cellRemovedAtIndexPath:indexPath];
    } else {
        cell.hidden = hidden;
        NSIndexPath *indexPath = [self indexPathOfCell:cell];
        CBSection *section = [self sectionAtIndex:indexPath.section];
        [(id<CBTableDelegate>)self.delegate table:self
                                          section:section
                             cellAddedAtIndexPath:indexPath];
    }
}
- (void) setCellAtIndexPath:(NSIndexPath*)indexPath hidden:(BOOL)hidden
{
    CBCell *cell = [self cellForRowAtIndexPath:indexPath];
    [self setCell:cell hidden:hidden];
}
- (void) setCellWithTag:(NSString*)tag hidden:(BOOL)hidden
{
    CBCell *cell = [self cellWithTag:tag];
    [self setCell:cell hidden:hidden];
}

@end
