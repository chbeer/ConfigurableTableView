//
//  CBCellNumericStepper.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "CBCell.h"

@interface CBCellNumericStepper : CBCell

@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float stepValue;

+ (id) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath 
            minValue:(float)min maxValue:(float)max stepValue:(float)step;

- (id) applyMinValue:(float)minValue;
- (id) applyMaxValue:(float)maxValue;
- (id) applyStepValue:(float)step;
- (id) applyMinValue:(float)minValue maxValue:(float)maxValue stepValue:(float)stepValue;

@end
