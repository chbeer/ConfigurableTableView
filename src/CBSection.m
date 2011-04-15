//
//  CBTableViewGroup.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBSection.h"

#import "CBConfigurableTableViewController.h"
#import "CBTable.h"
#import "CBCell.h"

@interface CBSection (Private)

- (void) addCellsVargs:(va_list)va;

@end


@implementation CBSection

@synthesize controller = _controller;
@synthesize table = _table;

@synthesize tag = _tag;

@dynamic title;

@dynamic cells;

@synthesize headerView = _headerView;

@synthesize footerTitle = _footerTitle;
@synthesize footerView = _footerView;

- (id) initWithTitle:(NSString*)title andCells:(NSArray*)cells {
	if (self = [super init]) {
		_title = [title copy];
		
		_cells = [cells mutableCopy];
	}
	return self;
}
- (id) initWithTitle:(NSString*)title {
	if (self = [self initWithTitle:title andCells:[NSArray array]]) {
	}
	return self;
}

+ (CBSection*) sectionWithTitle:(NSString*)title {
	CBSection *section = [[CBSection alloc] initWithTitle:title];
	return [section autorelease];
}
+ (CBSection*) sectionWithTitle:(NSString*)title andCells:(CBCell*)cell, ... {
	CBSection *section = [[CBSection alloc] initWithTitle:title];
	[section addCell:cell];
	
	va_list args;
    va_start(args, cell);
	[section addCellsVargs:args];
	
	return [section autorelease];
}

- (void) dealloc {
    [_tag release], _tag = nil;

	[_title release];
	[_cells release];
    
	[_headerView release];
    
    [_footerTitle release], _footerTitle = nil;
	[_footerView release];
	
	[super dealloc];
}

- (NSString*) title {
    return _title;
}
- (void) setTitle:(NSString *)title {
    if (_title != title) {
        [_title release];
        _title = [title copy];
        
        NSIndexSet *idxs = [NSIndexSet indexSetWithIndex:[_table indexOfSection:self]];
        [_controller.tableView reloadSections:idxs 
                             withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CBSection*) applyTag:(NSString *)tag {
    self.tag = tag;
    return self;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"CBSection {title: %@, cells: %@}", _title, _cells];
}

#pragma mark Cell access

- (NSInteger) cellCount {
	return _cells.count;
}

- (CBCell*) cellAtIndex:(NSUInteger)idx {
	return [_cells objectAtIndex:idx];
}
- (NSUInteger) indexOfCell:(CBCell*)cell {
	return [_cells indexOfObject:cell];
}

- (CBCell*) addCell:(CBCell*)cell {
	cell.section = self;
	[_cells addObject:cell];
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellAdded:)]) {
		[_table.delegate table:self.table 
					   section:self
					 cellAdded:cell];
	}
	
	return cell;
}
- (CBCell*) insertCell:(CBCell*)cell atIndex:(NSUInteger)index {
	cell.section = self;
	[_cells insertObject:cell atIndex:index];
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellAdded:)]) {
		[_table.delegate table:self.table 
					   section:self 
					 cellAdded:cell];
	}
	
	return cell;
}

- (CBCell*) cellWithTag:(NSString*)tag {
    if (!tag || [@"" isEqual:tag]) return nil;
    
    // linear search since we are optimized for a small amount of cells
    for (CBCell *cell in _cells) {
        if ([tag isEqual:cell.tag]) {
            return cell;
        }
    }
    
    return nil;
}

- (void) addCells:(CBCell*)cell, ... {
	[self addCell:cell];
	
	va_list args;
    va_start(args, cell);
	[self addCellsVargs:args];
}

- (void) addCellsFromArray:(NSArray*)cells {
	for (CBCell *c in cells) {
		[self addCell:c];
	}
}

- (void) addCellsVargs:(va_list)args {
	CBCell *c;
    while (c = va_arg(args, CBCell *)) {
        [self addCell:c];
    }
	va_end(args);
}

- (CBCell*) removeCell:(CBCell*)cell {
	NSIndexPath *idx = [_table indexPathOfCell:cell];
	
	[_cells removeObject:cell];
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellRemovedAtIndexPath:)]) {
		[_table.delegate table:self.table 
					   section:self cellRemovedAtIndexPath:idx];
	}
	
	return cell;
}
- (void) removeCells:(CBCell*)cell, ... {
    NSMutableArray *cells = [NSMutableArray arrayWithObject:cell];
    NSMutableArray *idxs = [NSMutableArray arrayWithObject:[_table indexPathOfCell:cell]];

    va_list args;
    va_start(args, cell);
    CBCell *c;
    while (c = va_arg(args, CBCell *)) {
        NSIndexPath *idx = [_table indexPathOfCell:c];
        if (idx) {
            [cells addObject:c];
            [idxs addObject:idx];
        }
    }
	va_end(args);
    
    [_cells removeObjectsInArray:cells];
    
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellRemovedAtIndexPath:)]) {
		[_table.delegate table:self.table 
					   section:self 
        cellsRemovedAtIndexPaths:idxs];
	}
}

- (NSArray*) cells {
	return [[_cells copy] autorelease];
}

@end
