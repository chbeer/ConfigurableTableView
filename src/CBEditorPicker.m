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

- (id) initWithOptions:(NSArray*)options {
	if (self = [super init]) {
		_options = [options mutableCopy];
	}
	return self;
}

+ (id) editorWithOptions:(NSArray*)options {
	CBEditorPicker *editor = [(CBEditorPicker*)[[self class] alloc] initWithOptions:options];
	return [editor autorelease];
}

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl {
	CBOptionsPickerController *pc = [[CBOptionsPickerController alloc] initWithOptions:_options frame:ctrl.view.bounds];
	[pc setSelectedValue:[ctrl valueForCell:cell]];
	[pc openEditorForCell:cell inController:ctrl];
    [ctrl.tableView scrollToRowAtIndexPath:[ctrl.model indexPathOfCell:cell]
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];
}


@end
