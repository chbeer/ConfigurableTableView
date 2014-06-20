//
//  CBTextFieldTableViewCell.m
//
//  Created by Christian Beer on 20.07.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBTextFieldTableViewCell.h"

#import "CBCTVGlobal.h"

// table view cell content offsets
#define kCellLeftOffset			10.0
#define kCellTopOffset			10.0

#define kTextFieldHeight		25.0

@implementation CBTextFieldTableViewCell

@synthesize textField = _textField;

@synthesize keyboardType = _keyboardType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id)initWithReuseIdentifier:(NSString *)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleDefault 
                    reuseIdentifier:identifier]) {
		// turn off selection use
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
		textField.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
		textField.keyboardAppearance = UIKeyboardAppearanceAlert;
		textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.backgroundColor = self.backgroundColor;
        textField.delegate = self;
		[self setTextField:textField];
	}
	return self;
}

- (id)initWithReuseIdentifier:(NSString *)identifier andLabel:(NSString*)label {
	if (self = [self initWithReuseIdentifier:identifier]) {
		_textField.placeholder = label;
        _textField.accessibilityLabel = label;
	}
	return self;
}

- (void)setTextField:(UITextField *)inView {
	
	
	_textField = inView;

	_textField.delegate = self;
	
	[self.contentView addSubview:_textField];
	[self layoutSubviews];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect contentRect = [self.contentView bounds];
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    CGFloat horizontalMargin = CBCTVIsIOS7() ? 15.0 : 10.0;
	CGRect frame = CGRectMake(horizontalMargin, kCellTopOffset,
                              contentRect.size.width - (horizontalMargin*2.0),
                              kTextFieldHeight);
	_textField.frame  = frame;

    _textField.keyboardType = _keyboardType;
    _textField.autocorrectionType = _autocorrectionType;
    _textField.autocapitalizationType = _autocapitalizationType;
    
    if (self.textLabel.superview) {
        [self.textLabel removeFromSuperview];
    }
}

- (void)dealloc {
    _textField.delegate = nil;
	if ([_textField isFirstResponder]) {
		[_textField resignFirstResponder];
	}
	
    _textField = nil;
	
}

- (void)stopEditing {
    if (_object && _keyPath) {
        [_object setValue:_textField.text
               forKeyPath:_keyPath];
    }
    
    [_textField resignFirstResponder];
}

- (void)setValue:(id)value {
	_textField.text = [NSString stringWithFormat:@"%@", value];
}

#pragma mark -
#pragma mark <UITextFieldDelegate> Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[_textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_object && _keyPath) {
        [_object setValue:textField.text
               forKeyPath:_keyPath];
    }
    
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_object && _keyPath) {
        [_object setValue:text
               forKeyPath:_keyPath];
    }
    
    return YES;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    if (_object && _keyPath) {
        [_object setValue:nil
               forKeyPath:_keyPath];
    }
    
    return YES;
}

@end
