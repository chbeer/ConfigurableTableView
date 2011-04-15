//
//  SliderCell.h
//  VocabuTrainer
//
//  Created by Christian Beer on 25.11.08.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBConfigTableViewCell.h"

@interface CBSliderCell : CBConfigTableViewCell {
	UISlider *slider;
	
    float _minValue;
	UILabel *minLabel;
    float _maxValue;
	UILabel *maxLabel;
    
    BOOL _showValue;
    NSString *_valueFormat;
    
    BOOL _continuous;
}

@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;

@property (nonatomic, getter=isShowValue) BOOL showValue;
@property (nonatomic, copy) NSString *valueFormat;

@property (nonatomic, getter=isContinuous) BOOL continuous;


- (id)initWithReuseIdentifier:(NSString *)identifier;

- (void)setMinLabel:(NSString*)min maxLabel:(NSString*)max;

-(void) setValue:(float)value;
- (float)value;

@end
