//
//  CBEditorController.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBCell.h"
#import "CBEditor.h"

@protocol CBEditorController

@property (nonatomic, assign) id<CBEditorDelegate> delegate;

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller;

@end


@interface CBCTVEditorViewController : UIViewController <CBEditorController> {
	id<CBEditorDelegate> __weak _delegate;
	CBCell *_cell;	
	CBConfigurableTableViewController *_controller;	
}

@property (nonatomic, weak) id<CBEditorDelegate> delegate;

@end