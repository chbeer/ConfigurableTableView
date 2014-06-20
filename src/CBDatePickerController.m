//
//  CBDatePickerController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBDatePickerController.h"


@implementation CBDatePickerController

@dynamic datePickerMode;

- (id) init {
	if (self = [super init]) {
		CGRect screen = [UIScreen mainScreen].bounds;
		self.view.frame = screen;
		self.view.backgroundColor = [UIColor colorWithRed:1.0 
													green:1.0 
													 blue:1.0 
													alpha:0.5];
		
		UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screen.size.height - 200, 
																 screen.size.width, 200)];
		
		[self.view addSubview:picker];
		_picker = picker;
		
	}
	return self;
}

- (void)dealloc {
	self.delegate = NULL;
	
	
}

- (IBAction)done:(id)sender {
	NSDate *date = ((UIDatePicker*)_picker).date;
	[_controller setValue:date forCell:_cell];
	
	if (_delegate && [_delegate respondsToSelector:@selector(editor:didChangeValue:)]) {
		[_delegate editor:self didChangeValue:date];
	}
	
	[self closeEditor];
}

- (BOOL) setSelectedValue:(id)value {
	if (value && [value isKindOfClass:[NSDate class]]) {
		[(UIDatePicker*)_picker setDate:(NSDate*)value animated:YES];
		return YES;
	}
	
	return NO;
}

//=========================================================== 
//  mode 
//=========================================================== 
- (UIDatePickerMode) datePickerMode
{
    return ((UIDatePicker*)_picker).datePickerMode;
}
- (void) setDatePickerMode: (UIDatePickerMode) aMode
{
    ((UIDatePicker*)_picker).datePickerMode = aMode;
}

@end
