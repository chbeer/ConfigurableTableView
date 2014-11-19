//
//  CBEditorNumeric.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorNumeric.h"

#import "CBNumericEditorController.h"
#import "CBConfigurableTableViewController.h"

@implementation CBEditorNumeric
{
    CBNumericEditorController *_editorController;
}

- (void) openEditorForCell:(CBCell*)cell
              inController:(CBConfigurableTableViewController*)ctrl {
    CBNumericEditorController *pc = [[CBNumericEditorController alloc] initWithValue:[ctrl valueForCell:cell]
                                                                            andTitle:cell.title];
    _editorController = pc;
    [_editorController openEditorForCell:cell inController:ctrl];
}

- (BOOL) isInline {
    return NO;
}

@end
