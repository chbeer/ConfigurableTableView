//
//  CBStepperCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "CBStepperCell.h"

@implementation CBStepperCell

@synthesize stepper = _stepper;

@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;
@synthesize stepValue = _stepValue;

@synthesize showValue   = _showValue;
@synthesize valueFormat = _valueFormat;

@dynamic value;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
	self = [super initWithStyle:style 
                reuseIdentifier:identifier];
    if (!self) return nil;
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    [stepper sizeToFit];
    self.accessoryView = stepper;
    self.stepper = stepper;
    [stepper release];
		
    [stepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];
		
	_minValue  = 0.0;
    _maxValue  = 1.0;
    _stepValue = 0.1;
    
    _showValue = NO;
        
    self.selectionStyle = UITableViewCellSelectionStyleNone;

	return self;
}
- (id)initWithReuseIdentifier:(NSString *)identifier {
    return [self initWithStyle:UITableViewCellStyleValue1 
               reuseIdentifier:identifier];
}

- (void) dealloc {
    self.stepper = nil;
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
	self.stepper.highlighted = selected;
	self.textLabel.highlighted = selected;
	
}

- (void) displayValue
{
    NSString *v = nil;
    if (_valueFormat) {
        v = [NSString stringWithFormat:self.valueFormat, self.stepper.value];
    } else {
        v = [NSString stringWithFormat:@"%f", self.stepper.value];
    }
    self.detailTextLabel.text = v;
}

-(void) setValue:(double)value {	
    self.stepper.minimumValue = _minValue;
    self.stepper.maximumValue = _maxValue;
    self.stepper.stepValue = _stepValue;
    
	self.stepper.value = value;

    if (self.showValue) {
        [self displayValue];
    }
}
- (double)value {
	return self.stepper.value;
}

- (void) stepperChanged:(UIStepper*)sender {
    if (_object && _keyPath) {
        [_object setValue:[NSNumber numberWithDouble:sender.value]
               forKeyPath:_keyPath];
        
        if (self.showValue) {
            [self displayValue];
        }
    }
}

@end
