//
//  CBEditorString.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEditor.h"

@interface CBEditorString : CBEditor {
	UIKeyboardType _keyboardType;
	UITextAutocorrectionType _autocorrectionType;
    UITextAutocapitalizationType _autocapitalizationType;
}

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;

+ (CBEditor*) editorWithKeyboardType:(UIKeyboardType)keyboardType
				  autocorrectionType:(UITextAutocorrectionType)autocorrectionType;
+ (CBEditor*) editorWithKeyboardType:(UIKeyboardType)keyboardType;
+ (CBEditor*) editorWithAutocorrectionType:(UITextAutocorrectionType)autocorrectionType;

@end
