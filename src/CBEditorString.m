//
//  CBEditorString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBEditorString.h"

#import "CBConfigurableTableView/CBStringEditorController.h"
#import "CBConfigurableTableView/CBConfigurableTableViewController.h"

@implementation CBEditorString

@synthesize keyboardType = _keyboardType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id) init {
	self = [super init];
    if (!self) return nil;
    
    _keyboardType = UIKeyboardTypeDefault;
    _autocorrectionType = UITextAutocorrectionTypeDefault;
    _autocapitalizationType = UITextAutocapitalizationTypeNone;
	
    return self;
}

+ (CBEditor*) editorWithKeyboardType:(UIKeyboardType)keyboardType 
				  autocorrectionType:(UITextAutocorrectionType)autocorrectionType {
	CBEditorString *es = (CBEditorString*)[self editor];
	es.keyboardType = keyboardType;
	es.autocorrectionType = autocorrectionType;
	return es;
}
+ (CBEditor*) editorWithKeyboardType:(UIKeyboardType)keyboardType {
	return [self editorWithKeyboardType:keyboardType
                     autocorrectionType:UITextAutocorrectionTypeDefault];
}
+ (CBEditor*) editorWithAutocorrectionType:(UITextAutocorrectionType)autocorrectionType {
	return [self editorWithKeyboardType:UIKeyboardTypeDefault
                     autocorrectionType:autocorrectionType];
}

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl {
	CBStringEditorController *pc = [[CBStringEditorController alloc] initWithText:[ctrl valueForCell:cell] 
																		 andTitle:cell.title];
	pc.keyboardType = _keyboardType;
	pc.autocorrectionType = _autocorrectionType;
    pc.autocapitalizationType = _autocapitalizationType;
	[pc openEditorForCell:cell inController:ctrl];
	
	[pc autorelease];
}

- (BOOL) isInline {
	return NO;
}

@end
