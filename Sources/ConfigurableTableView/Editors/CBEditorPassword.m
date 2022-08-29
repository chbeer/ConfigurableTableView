//
//  CBEditorPassword.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorPassword.h"

#import "CBConfigurableTableViewController.h"
#import "CBStringEditorController.h"

@implementation CBEditorPassword
{
    CBStringEditorController *_editorController;
}

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl
{
    if (!_editorController) {
        CBStringEditorController *pc = [[CBStringEditorController alloc] initWithText:[ctrl valueForCell:cell]
                                                                             andTitle:cell.title];
        pc.secureTextEntry = YES;
        _editorController = pc;
    }
	[_editorController openEditorForCell:cell inController:ctrl];
}

- (BOOL) isInline {
	return NO;
}

@end
