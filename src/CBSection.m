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
#import "CBEditor.h"

@interface CBSection (Private)

- (void) addCellsVargs:(va_list)va;

@end


@implementation CBSection
{
    NSArray *_visibleCells;
}

@synthesize controller = _controller;
@synthesize table = _table;

@synthesize hidden = _hidden;
@synthesize tag = _tag;

@dynamic title;

@dynamic cells;

@synthesize headerView = _headerView;

@synthesize footerTitle = _footerTitle;
@synthesize footerView = _footerView;

- (instancetype) initWithTitle:(NSString*)title andCells:(NSArray*)cells {
	if (self = [super init]) {
		_title = [title copy];
		
		_cells = [cells mutableCopy];
	}
	return self;
}
- (instancetype) initWithTitle:(NSString*)title {
	if (self = [self initWithTitle:title andCells:[NSArray array]]) {
	}
	return self;
}

+ (instancetype) sectionWithTitle:(NSString*)title {
	CBSection *section = [[self alloc] initWithTitle:title];
	return section;
}
+ (instancetype) sectionWithTitle:(NSString*)title andCells:(CBCell*)cell, ... {
	CBSection *section = [[self alloc] initWithTitle:title];
	[section addCell:cell];
	
	va_list args;
    va_start(args, cell);
	[section addCellsVargs:args];
	
	return section;
}

- (void) dealloc {
    _tag = nil;

    
    
    _footerTitle = nil;
	
}

- (NSString*) title {
    return _title;
}
- (void) setTitle:(NSString *)title {
    if (_title != title) {
        _title = [title copy];
        
        NSIndexSet *idxs = [NSIndexSet indexSetWithIndex:[_table indexOfSection:self]];
        [_controller.tableView reloadSections:idxs 
                             withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (instancetype) applyTag:(NSString *)tag {
    self.tag = tag;
    return self;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"CBSection {title: %@, tag: %@, hidden: %d, cells: %@}", _title, _tag, _hidden, _cells];
}

#pragma mark Cell access

- (void) reloadVisibleCells
{
    _visibleCells = [_cells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        CBCell *cell = evaluatedObject;
        return cell.hidden == NO;
    }]];
}

- (NSInteger) visibleCellCount
{
    [self reloadVisibleCells];
    return _visibleCells.count;
}
- (CBCell*) visibleCellAtIndex:(NSUInteger)idx {
    return [_visibleCells objectAtIndex:idx];
}
- (NSUInteger) indexOfVisibleCell:(CBCell*)cell {
    return [_visibleCells indexOfObject:cell];
}
- (NSUInteger) indexOfVisibleCellWithTag:(NSString*)tag {
    return [_visibleCells indexOfObject:[self cellWithTag:tag]];
}

- (NSInteger) cellCount
{
	return _cells.count;
}

- (CBCell*) cellAtIndex:(NSUInteger)idx {
	return [_cells objectAtIndex:idx];
}
- (NSUInteger) indexOfCell:(CBCell*)cell {
	return [_cells indexOfObject:cell];
}
- (NSUInteger) indexOfCellWithTag:(NSString*)tag {
	return [_cells indexOfObject:[self cellWithTag:tag]];
}

- (CBCell*) addCell:(CBCell*)cell {
	cell.section = self;
	[_cells addObject:cell];
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellAdded:)]) {
        NSIndexPath *indexPath = [_table indexPathOfCell:cell];
		[_table.delegate table:self.table 
					   section:self
          cellAddedAtIndexPath:indexPath];
	}
	
	return cell;
}
- (CBCell*) insertCell:(CBCell*)cell atIndex:(NSUInteger)index {
	cell.section = self;
	[_cells insertObject:cell atIndex:index];
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellAdded:)]) {
        NSIndexPath *indexPath = [_table indexPathOfCell:cell];
		[_table.delegate table:self.table 
					   section:self 
          cellAddedAtIndexPath:indexPath];
	}
	
	return cell;
}
- (void) insertCells:(NSArray*)cells atIndex:(NSUInteger)index {
    NSUInteger idx = index;
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSInteger section = [_table indexOfSection:self];
    for (CBCell *cell in cells) {
        cell.section = self;
        [_cells insertObject:cell atIndex:idx];
        [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
        idx++;
    }
	
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellsAdded:)]) {
        
		[_table.delegate table:self.table 
					   section:self 
        cellsAddedAtIndexPaths:indexPaths];
	}
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
- (CBCell*) cellWithValueKeyPath:(NSString*)valuePath
{
    if (!valuePath || [@"" isEqual:valuePath]) return nil;
    
    // linear search since we are optimized for a small amount of cells
    for (CBCell *cell in _cells) {
        if ([valuePath isEqual:cell.valueKeyPath]) {
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
    while ((c = va_arg(args, CBCell *))) {
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
- (void) removeCellsInArray:(NSArray*)cells {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (CBCell *cell in cells) {
        [indexPaths addObject:[self.table indexPathOfCell:cell]];
    }
    
    [_cells removeObjectsInArray:cells];
    
	if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:section:cellsRemovedAtIndexPaths:)]) {
		[_table.delegate table:self.table 
					   section:self 
      cellsRemovedAtIndexPaths:indexPaths];
	}
}
- (void) removeCells:(CBCell*)cell, ... {
    NSMutableArray *cells = [NSMutableArray arrayWithObject:cell];

    va_list args;
    va_start(args, cell);
    CBCell *c;
    while ((c = va_arg(args, CBCell *))) {
        NSIndexPath *idx = [self.table indexPathOfCell:c];
        if (idx) {
            [cells addObject:c];
        }
    }
	va_end(args);
    
    [self removeCellsInArray:cells];
}
- (CBCell*) removeCellWithTag:(NSString*)cellTag
{
    CBCell *cell = [self cellWithTag:cellTag];
    if (cell) {
        [self removeCell:cell];
    }
    return cell;
}

- (NSArray*) cells {
	return [_cells copy];
}

- (void) setHidden:(BOOL)hidden
{
    [self setHidden:hidden tellDelegate:YES];
}
- (void) setHidden:(BOOL)hidden tellDelegate:(BOOL)tellDelegate
{
    if (_hidden != hidden) {
        NSUInteger index = [_table indexOfSection:self];
        
        _hidden = hidden;
        
        if (tellDelegate) {
            if (_hidden) {
                if (index != NSNotFound && _table.delegate && [_table.delegate respondsToSelector:@selector(table:sectionRemovedAtIndex:)]) {
                    [_table.delegate table:_table sectionRemovedAtIndex:index];
                }
            } else {
                if (_table.delegate && [_table.delegate respondsToSelector:@selector(table:sectionAdded:)]) {
                    [_table.delegate table:_table sectionAdded:self];
                }
            }
        }
    }
}

- (UITableViewCell*) tableView:(UITableView*)tableView
             cellForRowAtIndex:(NSInteger)index
                    controller:(UIViewController*)ctrl
                        object:(id)object
{
    CBCell *cellModel = [self visibleCellAtIndex:index];
    cellModel.controller = (CBConfigurableTableViewController*)ctrl;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
    if (cell == nil) {
        cell = [cellModel createTableViewCellForTableView:tableView];
        
        if (cellModel.editor && [cellModel.editor respondsToSelector:@selector(cell:didCreateTableViewCell:)]) {
            cell = [(id<CBEditor>)cellModel.editor cell:cellModel didCreateTableViewCell:cell];
        }
        
    }
    
    // Set up the cell...
    [cellModel setupCell:cell
              withObject:object
             inTableView:tableView];
    
    return cell;

}

@end
