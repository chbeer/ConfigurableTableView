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
{
    CBDatePickerController *_datePickerController;
}

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
    _datePickerController = [[CBDatePickerController alloc] init];
    _datePickerController.datePickerMode = mode;
    [_datePickerController setSelectedValue:[ctrl valueForCell:cell]];
    [_datePickerController openEditorForCell:cell inController:ctrl];
}

@end
