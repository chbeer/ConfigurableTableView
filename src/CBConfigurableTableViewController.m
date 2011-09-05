//
//  CBConfigurableTableView.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableViewController.h"

#import "CBCTVGlobal.h"

#import "CBTable.h"
#import "CBSection.h"
#import "CBCell.h"
#import "CBEditorController.h"

@implementation CBConfigurableTableViewController

@synthesize tableView = _tableView;

@dynamic model;
@dynamic data;

@synthesize addAnimation = _addAnimation;
@synthesize removeAnimation = _removeAnimation;


- (id) initWithStyle:(UITableViewStyle)style {
	if (self = [super init]) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
		_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_tableView.dataSource = self;
		_tableView.delegate = self;
        _tableView.allowsSelectionDuringEditing = YES;
		[self.view addSubview:_tableView];
        [_tableView release];
        
        _addAnimation = UITableViewRowAnimationNone;
        _removeAnimation = UITableViewRowAnimationNone; 
        _reloadAnimation = UITableViewRowAnimationNone;
		
	}
	return self;
}
- (id)initWithTableModel:(CBTable*)model andData:(NSObject*)object {
	if (self = [self initWithStyle:UITableViewStyleGrouped]) {
		_model = [model retain];
		_model.delegate = self;
		
		_data = [object retain];
	}
	return self;
}
- (id)initWithTableModel:(CBTable*)model {
    if (self = [self initWithTableModel:model andData:NULL]) {
    }
    return self;
}

- (void) viewDidLoad {
	_tableView.frame = self.view.bounds;
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    if (!CBCTVIsIPad()) {
        [self addKeyboardObservers]; 
    }
}

- (void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    
    if (!CBCTVIsIPad()) {
        [self removeKeyboardObservers];
    }
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing 
             animated:animated];
    
    [_tableView setEditing:editing 
                  animated:animated];
}


- (void)dealloc {
	[_model release];
	[_data release];
	
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSObject *) data {
    return [[_data retain] autorelease]; 
}
- (void) setData: (NSObject *) aData {
    if (_data != aData) {
        [_data release];
        _data = [aData retain];
		
		[self.tableView reloadData];
    }
}

- (CBTable *) model {
    return [[_model retain] autorelease]; 
}
- (void) setModel: (CBTable *) aModel {
    if (_model != aModel) {
        [_model release];
        _model = [aModel retain];
		_model.delegate = self;
		
		[self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_model sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	CBSection *cbSection = [_model sectionAtIndex:section];
    if (cbSection.controller == nil) {
        cbSection.controller = self;
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
        return [tableView sectionHeaderHeight] + (tableView.style == UITableViewStyleGrouped ? 20 : 0);
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
    } else if (sect.footerTitle) {
        return 24.0;
    } else {
        return 0.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	CBCell *cellModel = [_model cellForRowAtIndexPath:indexPath];
    
    cellModel.controller = self;
    
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
            [cbCell openEditorInController:self];
        }
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CBCell *cbCell = [_model cellForRowAtIndexPath:indexPath];
    return [cbCell heightForCellInTableView:tableView withObject:_data];
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
- (void) table:(CBTable*)table section:(CBSection*)section cellRemovedAtIndexPath:(NSIndexPath*)indexPath {
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						  withRowAnimation:_removeAnimation];
}
- (void) table:(CBTable*)table section:(CBSection*)section cellsRemovedAtIndexPaths:(NSArray*)indexPaths {
	[self.tableView deleteRowsAtIndexPaths:indexPaths
						  withRowAnimation:_removeAnimation];
}


#pragma mark Keyboard

- (void) addKeyboardObservers;
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];
}
- (void) removeKeyboardObservers;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification 
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification 
                                                  object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notif {
    if (_kbDidShow) {
        return;
    }
    
	[UIView beginAnimations:@"keyboardWillShow" 
					context:nil];
	
	[UIView setAnimationCurve:[[notif.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
	[UIView setAnimationDuration:[[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
	
	CGRect frame = _tableView.frame;
    
    CGFloat heightDifference = 0.0;
    if (CBCTVIsIPad() && UIKeyboardFrameEndUserInfoKey != nil) {
        CGRect keyboardFrame = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        keyboardFrame = [self.view convertRect:keyboardFrame 
                                      fromView:nil];
        
        heightDifference = CGRectGetMaxY(frame) - CGRectGetMinY(keyboardFrame);

    } else {

        heightDifference = [[notif.userInfo objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue].size.height;
        
        if (!self.navigationController.toolbarHidden) {
            heightDifference -= self.navigationController.toolbar.bounds.size.height;
        } else if (self.navigationController.tabBarController) {
            heightDifference -= self.navigationController.tabBarController.tabBar.frame.size.height;
        }

    }

	frame.size.height -= heightDifference;
    
	_tableView.frame = frame;
    
	[UIView commitAnimations];
    
    _kbDidShow = YES;
}
- (void)keyboardWillHide:(NSNotification*)notif {
    if (!_kbDidShow) {
        return;
    }
    
	[UIView beginAnimations:@"keyboardWillShow" 
					context:nil];
	
	[UIView setAnimationCurve:[[notif.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
	[UIView setAnimationDuration:[[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
	
    _tableView.frame = self.view.bounds;
    
	[UIView commitAnimations];
    
    _kbDidShow = NO;
}


@end

