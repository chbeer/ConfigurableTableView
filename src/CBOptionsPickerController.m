//
//  CBOptionsPickerController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBOptionsPickerController.h"

#import "CBPickerOption.h"

@implementation CBOptionsPickerController

- (id) initWithOptions:(NSArray*)options {
    if (self = [self initWithOptions:options frame:[UIScreen mainScreen].bounds]) {
    }
    return self;
}
- (id) initWithOptions:(NSArray*)options frame:(CGRect)frame {
	if (self = [super init]) {
		_options = [options mutableCopy];
		
		self.view.frame = frame;
		self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
		
		UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, frame.size.height - 200, 
																			  frame.size.width, 200)];
		_picker = picker;
		picker.showsSelectionIndicator = YES;
		picker.delegate = self;
        picker.dataSource = self;
		[self.view addSubview:_picker];
		
	}
	return self;
}

- (void)dealloc {
	self.delegate = NULL;
	
	
}

- (IBAction)done:(id)sender {
	UIPickerView *picker = (UIPickerView*)_picker;
	
	id val = [_options objectAtIndex:[picker selectedRowInComponent:0]];
	if ([val isKindOfClass:[CBPickerOption class]]) {
		val = ((CBPickerOption*)val).value;
	} 
	
	[_controller setValue:val forCell:_cell];
	
	if (_delegate && [_delegate respondsToSelector:@selector(editor:didChangeValue:)]) {
		[_delegate editor:self didChangeValue:val];
	}
	
	[self closeEditor];
}

- (BOOL) setSelectedValue:(id)value {
	int idx = -1;
	
	int i = 0;
	for (id val in _options) {
		if ([val isKindOfClass:[CBPickerOption class]]) {
			if ([value isEqual:((CBPickerOption*)val).value]) {
				idx = i;
			}
		} else if ([value isEqual:val]) {
			idx = i;
		}
		i++;
	}
	
	if (idx >= 0) {
		UIPickerView *picker = (UIPickerView*)_picker;
		[picker selectRow:idx inComponent:0 animated:NO];
		
		return YES;
	}
	
	return NO;
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component {
	id lbl = [_options objectAtIndex:row];
	if ([lbl isKindOfClass:[CBPickerOption class]]) {
		lbl = ((CBPickerOption*)lbl).label;
	}
	return [NSString stringWithFormat:@"%@", lbl];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [_options count];
}

@end
