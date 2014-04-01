//
//  CBEditorDatePicker.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorDatePicker.h"

#import "CBDatePickerController.h"

@implementation CBEditorDatePicker

@synthesize mode;

- (id) init {
	if (self = [super init]) {
		mode = UIDatePickerModeDate;
	}
	return self;
}

+ (CBEditorDatePicker*) editorWithMode:(UIDatePickerMode)datePickerMode {
	CBEditorDatePicker *datePicker = (CBEditorDatePicker*)[super editor];
	datePicker.mode = datePickerMode;
	return datePicker;
}

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)ctrl {
	CBDatePickerController *c = [[CBDatePickerController alloc] init];
	c.datePickerMode = mode;
    [c setSelectedValue:[ctrl valueForCell:cell]];
	[c openEditorForCell:cell inController:ctrl];
}

@end
