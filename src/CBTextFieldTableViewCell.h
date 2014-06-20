//
//  CBTextFieldTableViewCell.h
//
//  Created by Christian Beer on 20.07.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConfigTableViewCell.h"

@interface CBTextFieldTableViewCell : CBConfigTableViewCell <UITextFieldDelegate> {
    UITextField *_textField;
    
    UIKeyboardType _keyboardType;
	UITextAutocorrectionType _autocorrectionType;
    UITextAutocapitalizationType _autocapitalizationType;

}

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;

- (id)initWithReuseIdentifier:(NSString *)identifier;
- (id)initWithReuseIdentifier:(NSString *)identifier andLabel:(NSString*)label;

- (void)stopEditing;

@end
