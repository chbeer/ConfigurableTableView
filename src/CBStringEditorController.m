//
//  CBStringEditorController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBStringEditorController.h"

#import "CBCell.h"
#import "CBConfigurableTableViewController.h"

#import "CBTextFieldTableViewCell.h"

@implementation CBStringEditorController

@synthesize delegate = _delegate;

@synthesize secureTextEntry = _secureTextEntry;
@synthesize keyboardType = _keyboardType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id)initWithText:(NSString*)inText andTitle:(NSString*)title {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																				target:self
																				action:@selector(cancel:)];
		self.navigationItem.leftBarButtonItem = cancel;
		[cancel release];
		
		_saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																   target:self
																   action:@selector(save:)];
		_saveButton.style = UIBarButtonItemStyleDone;
		_saveButton.enabled = [inText length] > 0;
		self.navigationItem.rightBarButtonItem = _saveButton;
		
		self.navigationItem.title = title;
		
		_text = [inText copy];
		
		_keyboardType = UIKeyboardTypeDefault;
		_autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[_saveButton release], _saveButton = nil;
	[_text release], _text = nil;
	
    [super dealloc];
}

-(void) viewDidAppear:(BOOL)animated {
	[_textField becomeFirstResponder];
	[super viewDidAppear:animated];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIndetifier = @"CBStringEditorController";
	
    CBTextFieldTableViewCell *cell = (CBTextFieldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIndetifier];
    if (cell == nil) {
        cell = [[[CBTextFieldTableViewCell alloc] initWithReuseIdentifier:MyIndetifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_textField = (UITextField*)cell.textField;
		_textField.placeholder = self.navigationItem.title;
		_textField.enablesReturnKeyAutomatically = YES;
		_textField.returnKeyType = UIReturnKeyDone;
		_textField.delegate = self;
		
		_textField.secureTextEntry = _secureTextEntry;
		_textField.keyboardType = _keyboardType;
		_textField.autocorrectionType = _autocorrectionType;
        _textField.autocapitalizationType = _autocapitalizationType;
		
		_textField.text = _text;
    }
	
    return cell;
}
#pragma mark -
#pragma mark Actions


-(void)cancel:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender {
	[_controller setValue:_textField.text forCell:_cell];
	
	if (_delegate && [_delegate respondsToSelector:@selector(editor:didChangeValue:)]) {
		[_delegate editor:self didChangeValue:_textField.text];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.text.length > 0) {
		[textField resignFirstResponder];
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	self.navigationItem.rightBarButtonItem.enabled = (str.length > 0);
	
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	return YES;
}

#pragma mark -

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller {
	_cell = cell;
	_controller = controller;
	
	[controller.navigationController pushViewController:self animated:YES];
}

@end
