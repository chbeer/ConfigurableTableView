//
//  CBSelectorEditor.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBConfigurableTableViewController.h"
#import "CBEditorController.h"
#import "CBEditor.h"

@interface CBPickerController : CBCTVEditorViewController {

	UIView *_picker;
	UIToolbar *_toolbar;

}

- (BOOL) setSelectedValue:(id)value;

- (void) closeEditor;

@end
