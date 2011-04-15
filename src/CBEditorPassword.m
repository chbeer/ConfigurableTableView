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

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl {
	CBStringEditorController *pc = [[CBStringEditorController alloc] initWithText:[ctrl valueForCell:cell] 
																		 andTitle:cell.title];
	pc.secureTextEntry = YES;
	[pc openEditorForCell:cell inController:ctrl];
	
	[pc autorelease];
}

- (BOOL) isInline {
	return NO;
}

@end
