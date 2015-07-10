//
//  CBCharacterTableViewCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.07.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCharacterTableViewCell.h"

#import "CBCTVGlobal.h"

@interface CBCharacterTableViewCell (Private) <UITextFieldDelegate>

@end


@implementation CBCharacterTableViewCell

@synthesize textField = _textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		_textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
		_textField.font = [UIFont systemFontOfSize:18];
		_textField.textAlignment = NSTextAlignmentRight;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.delegate = self;
        _textField.textColor = [UIColor tableViewCellValueTextColor];
		[self.contentView addSubview:_textField];
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}

- (void) dealloc {
    _textField.delegate = nil;
    
}


- (void)layoutSubviews {
	[super layoutSubviews];
    
    CGRect contentRect = [self.contentView bounds];
    CGRect textLabelRect = self.textLabel.frame;
    CGRect textFieldRect = textLabelRect;
    
    CGFloat contentWidth = contentRect.size.width - 2 * textLabelRect.origin.x;
    CGFloat textFieldWidth = 50;
    
    textLabelRect.size.width -= textFieldWidth;
    
    textFieldRect.origin.x = textLabelRect.origin.x + contentWidth - textFieldWidth;
    textFieldRect.size.width = textFieldWidth;

    self.textLabel.frame = textLabelRect;
    _textField.frame = textFieldRect;
}

- (void)stopEditing {
    [_textField resignFirstResponder];
//    [self textFieldDidEndEditing:_textField];
}

#pragma mark <UITextFieldDelegate> Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([_textField.text length] == 1) {
		[self stopEditing];
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_textField.text.length >= 1 && range.length == 0) {
        string = [string substringToIndex:1];
        
        _textField.text = string;
        
        if (self.object && self.keyPath) {
            [self.object setValue:string 
                       forKeyPath:self.keyPath];
        }

		return NO; // return NO to not change text
	}
    return YES;
}

@end
