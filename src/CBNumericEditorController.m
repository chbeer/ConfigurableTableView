//
//  CBNumericEditorController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBNumericEditorController.h"

#import "CBTextFieldTableViewCell.h"
#import "CBConfigurableTableViewController.h"

@implementation CBNumericEditorController

- (id) initWithValue:(NSNumber*)value andTitle:(NSString*)title {
	if (self = [super initWithText:[NSString stringWithFormat:@"%@", value] 
						  andTitle:title]) {
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIndetifier = @"CBNumericEditorController";
	
    CBTextFieldTableViewCell *cell = (CBTextFieldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIndetifier];
    if (cell == nil) {
        cell = [[CBTextFieldTableViewCell alloc] initWithReuseIdentifier:MyIndetifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_textField = (UITextField*)cell.textField;
		_textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		_textField.placeholder = self.navigationItem.title;
		_textField.enablesReturnKeyAutomatically = YES;
		_textField.returnKeyType = UIReturnKeyDone;
		_textField.delegate = self;
		
		_textField.secureTextEntry = _secureTextEntry;
		
		_textField.text = _text;
    }
	
    return cell;
}

-(void)save:(id)sender {
	[_controller setValue:[NSNumber numberWithInt:[_textField.text intValue]] forCell:_cell];
	
	if (_delegate && [_delegate respondsToSelector:@selector(editor:didChangeValue:)]) {
		[_delegate editor:self didChangeValue:_textField.text];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
