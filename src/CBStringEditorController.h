//
//  CBStringEditorController.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBEditorController.h"

@interface CBStringEditorController : UITableViewController <CBEditorController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate> {
	id<CBEditorDelegate> _delegate;
	CBCell *_cell;	
	CBConfigurableTableViewController *_controller;	
	
	NSString *_text;
	
	UITextField *_textField;
	UIBarButtonItem *_saveButton;
	
	BOOL _secureTextEntry;
	UIKeyboardType _keyboardType;
	UITextAutocorrectionType _autocorrectionType;
    UITextAutocapitalizationType _autocapitalizationType;
}

@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;

- (id)initWithText:(NSString*)inText andTitle:(NSString*)title;

@end
