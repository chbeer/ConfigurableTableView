//
//  CBEditorStringInline.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 28.04.11.
//  Copyright 2011 Christian Beer. All rights reserved.
//

#import "CBEditorStringInline.h"

#import "CBConfigurableTableViewController.h"

#define kCBEditorStringInlineTag 0xf37e
#define kCBEditorTextFieldRightMargin 8.0

@implementation CBEditorStringInline

- (void)dealloc {
    
    [_textField release], _textField = nil;
    
    [super dealloc];
}

#pragma -

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl {
	
    [_textField becomeFirstResponder];
    
}


- (UITableViewCell*) cell:(CBCell*)cell didCreateTableViewCell:(UITableViewCell*)tableViewCell {

    _textField = [[UITextField alloc] initWithFrame:tableViewCell.textLabel.bounds];
    _textField.keyboardType = _keyboardType;
    _textField.autocapitalizationType = _autocapitalizationType;
    _textField.autocorrectionType = _autocorrectionType;
    _textField.tag = kCBEditorStringInlineTag;
    _textField.delegate = self;
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.textAlignment = UITextAlignmentRight;
    
    [tableViewCell.contentView addSubview:_textField];
    
    return tableViewCell;
    
}

- (void)cell:(CBCell *)cell didSetupTableViewCell:(UITableViewCell *)tableViewCell withObject:(id)object inTableView:(UITableView *)tableView {
    
    _cell = cell;
    
    CGRect cvBounds = tableViewCell.contentView.bounds;
    
    CGFloat y = roundf(cvBounds.size.height / 2 - 12);
    CGFloat x = roundf(cvBounds.size.width / 2 - kCBEditorTextFieldRightMargin);
    
    // layout subviews
    tableViewCell.contentView;
    
    _textField.frame = CGRectMake(x, y, x, 24);
    _textField.text = tableViewCell.detailTextLabel.text;
    _textField.textColor = tableViewCell.detailTextLabel.textColor;
    
    tableViewCell.detailTextLabel.hidden = YES;
    
}

- (BOOL) isInline {
	return YES;
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_cell.controller setValue:textField.text 
                       forCell:_cell];
	
    [textField resignFirstResponder];
    
    return YES;
}

@end
