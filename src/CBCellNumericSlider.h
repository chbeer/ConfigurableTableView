//
//  CBCellNumericSlider.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBCell.h"

@interface CBCellNumericSlider : CBCell {
	NSString *_minLabel;
	NSString *_maxLabel;
    
    BOOL _showValue;
    NSString *_valueFormat;
    
    float _minValue;
    float _maxValue;
    
    BOOL _continuous;
}

@property (nonatomic, copy) NSString *minLabel;
@property (nonatomic, copy) NSString *maxLabel;

@property (nonatomic, getter=isShowValue) BOOL showValue;
@property (nonatomic, copy) NSString *valueFormat;

@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;

@property (nonatomic, getter=isContinuous) BOOL continuous;

+ (CBCellNumericSlider*) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath minLabel:(NSString*)min maxLabel:(NSString*)max;

- (CBCellNumericSlider*) applyShowValue:(BOOL)showValue;
- (CBCellNumericSlider*) applyShowValue:(BOOL)showValue withFormat:(NSString*)format;

- (CBCellNumericSlider*) applyMinValue:(float)minValue;
- (CBCellNumericSlider*) applyMaxValue:(float)maxValue;
- (CBCellNumericSlider*) applyMinValue:(float)minValue maxValue:(float)maxValue;

@end
