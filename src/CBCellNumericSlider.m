//
//  CBCellNumericSlider.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellNumericSlider.h"

#import "CBConfigurableTableView/CBSliderCell.h"

@implementation CBCellNumericSlider

@synthesize minLabel = _minLabel, maxLabel = _maxLabel;

@synthesize showValue = _showValue;
@synthesize valueFormat = _valueFormat;

@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;

@synthesize continuous = _continuous;

+ (CBCell*) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath 
				 minLabel:(NSString*)min	maxLabel:(NSString*)max {
	CBCellNumericSlider *cell = [[[self class] alloc] initWithTitle:title 
                                                       andValuePath:valueKeyPath];
	cell.minLabel = min;
	cell.maxLabel = max;
    
	return [cell autorelease];
}

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
		_minLabel = NULL;
		_maxLabel = NULL;
        
        _minValue = 0.0f;
        _maxValue = 1.0f;
        
        _showValue = NO;
        _valueFormat = nil;
        
        _continuous = YES;
	}
	return self;
}

- (void) dealloc {
    [_valueFormat release], _valueFormat = nil;
    
    [super dealloc];
}

- (CBCellNumericSlider*) applyShowValue:(BOOL)showValue {
    self.showValue = showValue;
    return self;
}
- (CBCellNumericSlider*) applyShowValue:(BOOL)showValue withFormat:(NSString*)format {
    self.showValue = showValue;
    self.valueFormat = format;
    return self;
}

- (CBCellNumericSlider*) applyMinValue:(float)minValue {
    self.minValue = minValue;
    return self;
}
- (CBCellNumericSlider*) applyMaxValue:(float)maxValue {
    self.maxValue = maxValue;
    return self;
}
- (CBCellNumericSlider*) applyMinValue:(float)minValue maxValue:(float)maxValue {
    self.minValue = minValue;
    self.maxValue = maxValue;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellNumericSlider";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
    UITableViewCellStyle style = _showValue ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault;
	return [[[CBSliderCell alloc] initWithStyle:style reuseIdentifier:[self reuseIdentifier]] autorelease];
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	CBSliderCell *sc = (CBSliderCell*)cell;
	if (!value) {
		sc.value = 0;
	} else if ([value isKindOfClass:[NSNumber class]]) {
		sc.value = [((NSNumber*)value) floatValue];
	}
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	CBSliderCell *sc = (CBSliderCell*)cell;
    [sc setMinLabel:_minLabel maxLabel:_maxLabel];
    sc.minValue = _minValue;
    sc.maxValue = _maxValue;
    
    sc.showValue = _showValue;
    sc.valueFormat = _valueFormat;
    
    sc.continuous = _continuous;

	[super setupCell:cell withObject:object inTableView:tableView];
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object {
	float height = 44;
	
	if (self.title && ![@"" isEqual:self.title]) {
		height += 26;
	}
	
	if (_minLabel || _maxLabel) {
		height += 22;
	}
		
	return height;
}

@end
