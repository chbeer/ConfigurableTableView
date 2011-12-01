//
//  CBCellNumericStepper.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "CBCellNumericStepper.h"

#import "CBStepperCell.h"

@implementation CBCellNumericStepper

@synthesize minValue    = _minValue;
@synthesize maxValue    = _maxValue;
@synthesize stepValue   = _stepValue;


+ (id) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath 
				 minValue:(float)min maxValue:(float)max stepValue:(float)step {
	CBCellNumericStepper *cell = [[[self class] alloc] initWithTitle:title 
                                                        andValuePath:valueKeyPath];
    cell.minValue = min;
    cell.maxValue = max;
    cell.stepValue = step;
	return [cell autorelease];
}

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
        _minValue = 0.0f;
        _maxValue = 1.0f;
        _stepValue = 0.1f;
	}
	return self;
}

- (id) applyMinValue:(float)minValue {
    self.minValue = minValue;
    return self;
}
- (id) applyMaxValue:(float)maxValue {
    self.maxValue = maxValue;
    return self;
}
- (id) applyStepValue:(float)step {
    self.stepValue = step;
    return self;
}
- (id) applyMinValue:(float)minValue maxValue:(float)maxValue stepValue:(float)stepValue {
    self.minValue = minValue;
    self.maxValue = maxValue;
    self.stepValue = stepValue;
    return self;
}

#pragma mark CBCell protocol

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
    CBStepperCell *cell = [[CBStepperCell alloc] initWithReuseIdentifier:[self reuseIdentifier]];
	return [cell autorelease];
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	UIStepper *stepper = ((CBStepperCell*)cell).stepper;
	if (!value) {
		stepper.value = 0;
	} else if ([value isKindOfClass:[NSNumber class]]) {
		stepper.value = [((NSNumber*)value) intValue];
	}
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	UIStepper *stepper = ((CBStepperCell*)cell).stepper;

    stepper.minimumValue = self.minValue;
    stepper.maximumValue = self.maxValue;
    stepper.stepValue = self.stepValue;
    
	[super setupCell:cell withObject:object inTableView:tableView];
}

@end
