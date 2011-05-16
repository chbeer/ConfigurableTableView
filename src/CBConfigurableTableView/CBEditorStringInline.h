//
//  CBEditorStringInline.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 28.04.11.
//  Copyright 2011 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEditorString.h"

@interface CBEditorStringInline : CBEditorString <UITextFieldDelegate> {
    
    BOOL _secureTextEntry;
    UITextField *_textField;
    
    CBCell *_cell;
    
}

@property (nonatomic, assign) BOOL secureTextEntry;

- (id) applySecureTextEntry:(BOOL)secureTextEntry;

@end
