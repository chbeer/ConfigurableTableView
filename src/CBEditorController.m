//
//  CBEditorController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorController.h"

@implementation CBCTVEditorViewController

@synthesize delegate = _delegate;

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller {
	_cell = cell;
	_controller = controller;
}

@end
