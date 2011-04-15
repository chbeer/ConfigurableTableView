//
//  CBEditorDatePicker.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEditor.h"

@interface CBEditorDatePicker : CBEditor {
	UIDatePickerMode mode;
}

@property (nonatomic, assign) UIDatePickerMode mode;

+ (CBEditorDatePicker*) editorWithMode:(UIDatePickerMode)datePickerMode;

@end
