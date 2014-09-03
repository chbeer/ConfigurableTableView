//
//  CBPickerEditor.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorPicker.h"

#import "CBConfigurableTableViewController.h"

#import "CBOptionsPickerController.h"

@implementation CBEditorPicker
{
    CBOptionsPickerController *_pickerController;
}

- (id) initWithOptions:(NSArray*)options {
	if (self = [super init]) {
		_options = [options mutableCopy];
	}
	return self;
}

+ (id) editorWithOptions:(NSArray*)options {
	CBEditorPicker *editor = [(CBEditorPicker*)[[self class] alloc] initWithOptions:options];
	return editor;
}

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl
{
	_pickerController = [[CBOptionsPickerController alloc] initWithOptions:_options frame:ctrl.view.bounds];
	[_pickerController setSelectedValue:[ctrl valueForCell:cell]];
	[_pickerController openEditorForCell:cell inController:ctrl];
    [ctrl.tableView scrollToRowAtIndexPath:[ctrl.model indexPathOfCell:cell]
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];
}

@end
