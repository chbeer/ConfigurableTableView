//
//  CBEditorString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorString.h"

#import "CBStringEditorController.h"
#import "CBConfigurableTableViewController.h"

@implementation CBEditorString
{
    CBStringEditorController *_editorController;
}

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

+ (id) editorWithKeyboardType:(UIKeyboardType)keyboardType 
           autocorrectionType:(UITextAutocorrectionType)autocorrectionType {
	CBEditorString *es = (CBEditorString*)[self editor];
	es.keyboardType = keyboardType;
	es.autocorrectionType = autocorrectionType;
	return es;
}
+ (id) editorWithKeyboardType:(UIKeyboardType)keyboardType {
	return [self editorWithKeyboardType:keyboardType
                     autocorrectionType:UITextAutocorrectionTypeDefault];
}
+ (id) editorWithAutocorrectionType:(UITextAutocorrectionType)autocorrectionType {
	return [self editorWithKeyboardType:UIKeyboardTypeDefault
                     autocorrectionType:autocorrectionType];
}

- (id) applyKeyboardType:(UIKeyboardType)keyboardType;
{
    self.keyboardType = keyboardType;
    return self;
}
- (id) applyAutocorrectionType:(UITextAutocorrectionType)autocorrectionType;
{
    self.autocorrectionType = autocorrectionType;
    return self;
}
- (id) applyAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType;
{
    self.autocapitalizationType = autocapitalizationType;
    return self;
}

#pragma mark -

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl {
    if (!_editorController) {
        CBStringEditorController *pc = [[CBStringEditorController alloc] initWithText:[ctrl valueForCell:cell]
                                                                             andTitle:cell.title];
        pc.keyboardType = _keyboardType;
        pc.autocorrectionType = _autocorrectionType;
        pc.autocapitalizationType = _autocapitalizationType;
        _editorController = pc;
    }
    [_editorController openEditorForCell:cell inController:ctrl];
}

- (BOOL) isInline {
	return NO;
}

@end
