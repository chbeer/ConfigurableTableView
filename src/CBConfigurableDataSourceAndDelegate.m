//
//  CBConfigurableDataSourceAndDelegate.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.04.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBConfigurableDataSourceAndDelegate.h"

#import "CBSection.h"
#import "CBCell.h"

@implementation CBConfigurableDataSourceAndDelegate

@synthesize tableView = _tableView;
@synthesize controller = _controller;

@synthesize model = _model;
@synthesize data = _data;

@synthesize addAnimation = _addAnimation;
@synthesize removeAnimation = _removeAnimation;
@synthesize reloadAnimation = _reloadAnimation;


- (id) initWithTableView:(UITableView*)tableView;
{
    self = [super init];
    if (!self) return nil;
    
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    return self;
}

- (void)dealloc
{
    self.model = nil;
    self.data = nil;
    
    [super dealloc];
}

#pragma mark -

- (void) setModel: (CBTable *) aModel {
    if (_model != aModel) {
        [_model release];
        _model = [aModel retain];
		_model.delegate = self;
		
		[self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_model sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	CBSection *cbSection = [_model sectionAtIndex:section];
    if (cbSection.controller == nil) {
        cbSection.controller = self.controller;
    }
    return [cbSection cellCount];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	CBSection *cbSection = [_model sectionAtIndex:section];
    return cbSection.headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	CBSection *cbSection = [_model sectionAtIndex:section];
    return cbSection.title;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    UIView *v;
    if ((v = [self tableView:tableView viewForHeaderInSection:section])) {
        if ([v respondsToSelector:@selector(heightForHeaderInTableView:)]) {
            return [(id<CBSectionHeaderView>)v heightForHeaderInTableView:tableView];
        } else {
            return v.frame.size.height;
        }
    } else if ([[self tableView:tableView titleForHeaderInSection:section] length] > 0) {
        return [tableView sectionHeaderHeight] + (tableView.style == UITableViewStyleGrouped ? 24 : 0);
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	CBSection *sect = [_model sectionAtIndex:section];
	return sect.footerView;
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    CBSection *sect = [_model sectionAtIndex:section];
    return sect.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CBSection *sect = [_model sectionAtIndex:section];
    if (sect.footerView) {
        return sect.footerView.bounds.size.height;
    } else if ([sect.footerTitle length] > 0) {
        CGFloat width = tableView.bounds.size.width;
        CGSize constrain = CGSizeMake(width > 400 ? width - 120 : width - 50, 1000);
        CGSize size = [sect.footerTitle sizeWithFont:[UIFont systemFontOfSize:16]
                                   constrainedToSize:constrain 
                                       lineBreakMode:UILineBreakModeWordWrap];
        return size.height + 10;
    } else {
        return 0.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	CBCell *cellModel = [_model cellForRowAtIndexPath:indexPath];
    
    cellModel.controller = self.controller;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
    if (cell == nil) {
        cell = [cellModel createTableViewCellForTableView:tableView];
		
		if (cellModel.editor && [cellModel.editor respondsToSelector:@selector(cell:didCreateTableViewCell:)]) {
			cell = [cellModel.editor cell:cellModel didCreateTableViewCell:cell];
		}
		
    }
    
    // Set up the cell...
	[cellModel setupCell:cell 
			  withObject:_data 
			 inTableView:tableView];
	
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
	if ([cbCell hasEditor]) {
        if ([cbCell respondsToSelector:@selector(openEditorInController:)]) {
            [cbCell openEditorInController:self.controller];
        }
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
    CGFloat height = 44;
    if ([cbCell respondsToSelector:@selector(heightForCell:inTableView:withObject:)]) {
        height = [cbCell heightForCell:cbCell inTableView:tableView withObject:_data];
    } else if ([cbCell respondsToSelector:@selector(heightForCellInTableView:withObject:)]) {
        height = [cbCell heightForCellInTableView:tableView withObject:_data];
    }
    NSAssert(!isnan(height), @"Height should not be NaN!");
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark Value access

- (void) setValue:(id)value forCell:(CBCell*)cell withReload:(BOOL)reload {
	if (_data && cell.valueKeyPath) {
		[_data setValue:value forKeyPath:cell.valueKeyPath];
		
		NSIndexPath *idx = [_model indexPathOfCell:cell];
		if (reload && idx) {
			[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:idx] 
								  withRowAnimation:_reloadAnimation];
		}
	}
}
- (void) setValue:(id)value forCell:(CBCell*)cell {
	[self setValue:value forCell:cell withReload:YES];
}
- (id) valueForCell:(CBCell*)cell {
	if (_data && cell.valueKeyPath) {
		return [_data valueForKeyPath:cell.valueKeyPath];
	}
	return nil;
}

#pragma mark CBTableDelegate

- (void) table:(CBTable*)table sectionAdded:(CBSection*)section {
	NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:[table indexOfSection:section]];
	[self.tableView insertSections:idxSet 
                  withRowAnimation:_addAnimation];
}

- (void) table:(CBTable*)table sectionRemovedAtIndex:(NSUInteger)index {
	NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:index];
	[self.tableView deleteSections:idxSet 
                  withRowAnimation:_removeAnimation];
}

- (void) table:(CBTable*)table section:(CBSection*)section cellAdded:(CBCell*)cell {
	NSIndexPath *idxPath = [table indexPathOfCell:cell];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:idxPath] 
						  withRowAnimation:_addAnimation];
}
- (void) table:(CBTable*)table section:(CBSection*)section cellsAdded:(NSArray*)cells {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (CBCell *cell in cells) {
        NSIndexPath *idxPath = [table indexPathOfCell:cell];
        [indexPaths addObject:idxPath];
    }
	
	[self.tableView insertRowsAtIndexPaths:indexPaths
						  withRowAnimation:_addAnimation];
}
- (void) table:(CBTable*)table section:(CBSection*)section cellRemovedAtIndexPath:(NSIndexPath*)indexPath {
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						  withRowAnimation:_removeAnimation];
}
- (void) table:(CBTable*)table section:(CBSection*)section cellsRemovedAtIndexPaths:(NSArray*)indexPaths {
	[self.tableView deleteRowsAtIndexPaths:indexPaths
						  withRowAnimation:_removeAnimation];
}

@end
