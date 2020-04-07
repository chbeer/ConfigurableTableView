//
//  CBConfigurableDataSourceAndDelegate.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.04.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBConfigurableDataSourceAndDelegate.h"

#import "CBCTVGlobal.h"
#import "NSString+CBCTV.h"

#import "CBSection.h"
#import "CBCell.h"
#import "CBEditor.h"

@implementation CBConfigurableDataSourceAndDelegate

@synthesize tableView = _tableView;
@synthesize controller = _controller;

@synthesize model = _model;
@synthesize data = _data;

@synthesize addAnimation = _addAnimation;
@synthesize removeAnimation = _removeAnimation;
@synthesize reloadAnimation = _reloadAnimation;

@synthesize endEditingWhenScrolled = _endEditingWhenScrolled;


- (id) initWithTableView:(UITableView*)tableView;
{
    self = [super init];
    if (!self) return nil;
    
    self.tableView = tableView;
    
    return self;
}

- (void)dealloc
{
    self.model = nil;
    
}

#pragma mark -

- (void) setModel: (CBTable *) aModel {
    if (_model != aModel) {
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
        
        _model = aModel;
		_model.delegate = self;

        
        if (aModel) {
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            
            if (self.controller.isViewLoaded) {
                [self.tableView reloadData];
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_model sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	CBSection *cbSection = [_model sectionAtIndex:section];
    if (cbSection.controller == nil) {
        cbSection.controller = (CBConfigurableTableViewController*)self.controller;
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
        return [tableView sectionHeaderHeight] + (tableView.style == UITableViewStyleGrouped ? 38 : 0);
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
        CGFloat fontSize;
        CGFloat margin;
        if (CBCTVIsIOS7()) {
            fontSize = 13;
            margin = 33.5;
        } else {
            fontSize = 16;
            margin = 54;
        }
        
        CGFloat width = tableView.bounds.size.width;
        CGSize constraint = CGSizeMake(width - margin, 1000);//CGSizeMake(width > 400 ? width - 120 : width - 50, 1000);
        CGSize size = [sect.footerTitle cbctv_sizeWithFont:[UIFont systemFontOfSize:fontSize]
                                         constrainedToSize:constraint
                                             lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 18;
    } else {
        return 0.0;
    }
}
- (BOOL) hasSectionFooterView
{
    for (CBSection *section in _model.sections) {
        if (section.footerView) {
            return YES;
        }
    }
    return NO;
}
- (BOOL) hasSectionFooterTitle
{
    for (CBSection *section in _model.sections) {
        if (section.footerTitle.length > 0) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(tableView:heightForFooterInSection:) && ![self hasSectionFooterView]) {
        return NO;
    } else if (aSelector == @selector(tableView:titleForFooterInSection:) && ![self hasSectionFooterTitle]) {
        return NO;
    } else {
        return [super respondsToSelector:aSelector];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CBSection *section = [_model sectionAtIndex:indexPath.section];
    return [section tableView:tableView
            cellForRowAtIndex:indexPath.row
                   controller:self.controller
                       object:_data];    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
	if (cbCell.enabled && [cbCell hasEditor]) {
        if ([cbCell respondsToSelector:@selector(openEditorInController:)]) {
            [cbCell openEditorInController:self.controller];
        }
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
    if (cbCell.accessoryButtonHandler) {
        cbCell.accessoryButtonHandler(cbCell, tableView, indexPath);
        return;
    }
    if (cbCell.editor && [cbCell.editor respondsToSelector:@selector(configurableDataSource:cell:accessoryButtonTappedForRowWithIndexPath:)]) {
        [cbCell.editor configurableDataSource:self cell:cbCell accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
    cbCell.controller = self.controller;
    CGFloat height = 44;
    if ([cbCell respondsToSelector:@selector(heightForCell:atIndexPath:inTableView:withObject:)]) {
        height = [cbCell heightForCell:cbCell atIndexPath:indexPath inTableView:tableView withObject:_data];
    } else if ([cbCell respondsToSelector:@selector(heightForCell:inTableView:withObject:)]) {
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

- (void) setValue:(id)value forCell:(CBCell*)cell withReload:(BOOL)reload
{
	if (_data && cell.valueKeyPath) {
		[_data setValue:value forKeyPath:cell.valueKeyPath];
		
		NSIndexPath *idx = [_model indexPathOfCell:cell];
		if (reload && idx) {
            [self.tableView reloadRowsAtIndexPaths:@[idx]
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.endEditingWhenScrolled) {
        [self.tableView endEditing:YES];
    }
}

@end
