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

@synthesize dataSource = _dataSource;

@synthesize model = _model;
@synthesize data = _data;

@synthesize addAnimation = _addAnimation;
@synthesize removeAnimation = _removeAnimation;
@synthesize reloadAnimation = _reloadAnimation;


- (id) initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
    if (!self) return nil;
    
	return self;
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) return nil;
    
    return self;
}

- (id)initWithTableModel:(CBTable*)model andData:(NSObject*)object {
	self = [self initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;
    
    _model = model;
    _data = object;
    
    return self;
}
- (id)initWithTableModel:(CBTable*)model {
    return [self initWithTableModel:model andData:nil];
}

- (void) loadView
{
    [super loadView];
    
    self.dataSource = [[CBConfigurableDataSourceAndDelegate alloc] initWithTableView:self.tableView];
    self.dataSource.controller = self;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.allowsSelectionDuringEditing = YES;

    self.dataSource.model = _model;
    self.dataSource.model.delegate = self.dataSource;
    
    self.dataSource.data = _data;
}

/*- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.dataSource) {
        self.dataSource = [[[CBConfigurableDataSourceAndDelegate alloc] initWithTableView:self.tableView] autorelease];
        self.dataSource.controller = self;
    
        self.dataSource.model = self.model;
        self.dataSource.model.delegate = self.dataSource;
    }

    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.allowsSelectionDuringEditing = YES;

}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSObject *) data {
    return self.dataSource.data;
}
- (void) setData: (NSObject *) aData {
    if (_data != aData) {
        _data = aData;
        self.dataSource.data = aData;
    }
}

- (void) setModel: (CBTable *) aModel {
    if (_model != aModel) {
        _model = aModel;
        self.dataSource.model = aModel;
    }
}


#pragma mark Value access

- (void) setValue:(id)value forCell:(CBCell*)cell withReload:(BOOL)reload {
	[self.dataSource setValue:value forCell:cell withReload:reload];
}
- (void) setValue:(id)value forCell:(CBCell*)cell {
	[self setValue:value forCell:cell withReload:YES];
}
- (id) valueForCell:(CBCell*)cell {
	return [self.dataSource valueForCell:cell];
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
	
	CGRect frame = self.tableView.frame;
    
    CGFloat heightDifference = 0.0;
    if (CBCTVIsIPad() && UIKeyboardFrameEndUserInfoKey != nil) {
        CGRect keyboardFrame = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        keyboardFrame = [self.view convertRect:keyboardFrame 
                                      fromView:nil];
        
        heightDifference = CGRectGetMaxY(frame) - CGRectGetMinY(keyboardFrame);

    } else {

        heightDifference = CGRectGetHeight([[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]);
        
        if (!self.navigationController.toolbarHidden) {
            heightDifference -= self.navigationController.toolbar.bounds.size.height;
        } else if (self.navigationController.tabBarController) {
            heightDifference -= self.navigationController.tabBarController.tabBar.frame.size.height;
        }

    }

	frame.size.height -= heightDifference;
    
	self.tableView.frame = frame;
    
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
	
    self.tableView.frame = self.view.bounds;
    
	[UIView commitAnimations];
    
    _kbDidShow = NO;
}


@end

