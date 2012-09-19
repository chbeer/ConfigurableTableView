//
//  CBEditorStepper.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.09.12.
//
//

#import "CBEditorStepper.h"

@implementation CBEditorStepper

@synthesize stepper = _stepper;

- (UITableViewCell*) cell:(CBCell*)cell didCreateTableViewCell:(UITableViewCell*)tableViewCell {
    
    _textField = [[UITextField alloc] initWithFrame:tableViewCell.textLabel.bounds];
    _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textField.keyboardType = _keyboardType;
    _textField.autocapitalizationType = _autocapitalizationType;
    _textField.autocorrectionType = _autocorrectionType;
    _textField.tag = kCBEditorStringInlineTag;
    _textField.delegate = self;
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.textAlignment = UITextAlignmentRight;
    _textField.secureTextEntry = _secureTextEntry;
    
    [tableViewCell.contentView addSubview:_textField];
    
    return tableViewCell;
    
}

@end
