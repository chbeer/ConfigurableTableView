//
//  SliderCell.m
//  VocabuTrainer
//
//  Created by Christian Beer on 25.11.08.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBSliderCell.h"

#define kCellHeight				25.0
#define kCellLeftOffset			8.0
#define kCellTopOffset			10.0 

@implementation CBSliderCell

@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;

@synthesize showValue = _showValue;
@synthesize valueFormat = _valueFormat;

@synthesize continuous = _continuous;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
	if (self = [super initWithStyle:style 
					reuseIdentifier:identifier]) {
		slider = [[UISlider alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:slider];
		
		[slider addTarget:self 
                   action:@selector(sliderChanged:) 
         forControlEvents:UIControlEventValueChanged];
		
		minLabel = NULL;
		maxLabel = NULL;
        
        _minValue = 0;
        _maxValue = 1;
        
        _showValue = NO;
        _valueFormat = nil;
        
        _continuous = YES;
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}
- (id)initWithReuseIdentifier:(NSString *)identifier {
    if (self = [self initWithStyle:UITableViewCellStyleDefault 
					reuseIdentifier:identifier]) {
    }
    return self;
}

- (void) dealloc {
    [slider release], slider = nil;
    [_valueFormat release], _valueFormat = nil;
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

	slider.highlighted = selected;
	self.textLabel.highlighted = selected;
	
	if (minLabel && maxLabel) {
		minLabel.highlighted = selected;
		maxLabel.highlighted = selected;
	}
}

- (void) displayValue {
    CGRect contentRect = [self.contentView bounds];
    CGRect frame = CGRectMake(contentRect.origin.x + kCellLeftOffset, kCellTopOffset, 
							  roundf(contentRect.size.width - 2 * kCellLeftOffset), 
							  kCellHeight);
    
    NSString *v = nil;
    if (_valueFormat) {
        v = [NSString stringWithFormat:_valueFormat, slider.value];
    } else {
        v = [NSString stringWithFormat:@"%f", slider.value];
    }
    self.detailTextLabel.text = v;
    self.detailTextLabel.frame = CGRectMake(frame.size.width - 50, kCellTopOffset, 
                                            50, kCellHeight);
}
- (void) layoutSubviews {
	[super layoutSubviews];
    CGRect contentRect = [self.contentView bounds];
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
	CGRect frame = CGRectMake(contentRect.origin.x + kCellLeftOffset, kCellTopOffset, 
							  roundf(contentRect.size.width - 2 * kCellLeftOffset), 
							  kCellHeight);
	
	float nameLabelHeight = 0;
	if (self.textLabel && self.textLabel.text && ![self.textLabel.text isEqualToString:@""]) {
		nameLabelHeight = kCellHeight;
		self.textLabel.frame = CGRectMake(kCellLeftOffset, kCellTopOffset, 
										  frame.size.width, kCellHeight);
	}
	
	CGRect slFrame = CGRectMake(kCellLeftOffset,
								kCellTopOffset + nameLabelHeight + 3,
								frame.size.width,
								slider.bounds.size.height);
	slider.frame = slFrame;
    
	if (minLabel && maxLabel) {
		float slFrameHalf = roundf(slFrame.size.width / 2);
		CGRect minFrame = CGRectMake(kCellLeftOffset,
									 slider.frame.origin.y + slider.frame.size.height + 2,
									 slFrameHalf,
									 minLabel.frame.size.height);
		CGRect maxFrame = CGRectMake(kCellLeftOffset + slFrameHalf,
									 slider.frame.origin.y + slider.frame.size.height + 2,
									 slFrameHalf,
									 minLabel.frame.size.height);
		
		minLabel.frame = minFrame;
		maxLabel.frame = maxFrame;
    }
    
    if (_showValue) {
        [self displayValue];
    }
}

-(void) setValue:(float)value {	
    slider.minimumValue = _minValue;
    slider.maximumValue = _maxValue;

    slider.continuous = _continuous;
    
	slider.value = value;
}
- (float)value {
	return slider.value;
}

- (void)setMinLabel:(NSString*)min maxLabel:(NSString*)max {
    if (min) {
        if (!minLabel) {
            minLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 15)];
            minLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
            minLabel.textColor = [UIColor darkGrayColor];
            minLabel.backgroundColor = [UIColor clearColor];
            minLabel.opaque = NO;
            [self.contentView addSubview:minLabel];
            [minLabel release];
        }
        minLabel.text = min;
    } else {
        [minLabel removeFromSuperview]; 
        minLabel = nil;
    }
	
    if (max) {
        if (!maxLabel) {
            maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 15)];
            maxLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
            maxLabel.textColor = [UIColor darkGrayColor];
            maxLabel.textAlignment = UITextAlignmentRight;
            maxLabel.backgroundColor = [UIColor clearColor];
            maxLabel.opaque = NO;
            [self.contentView addSubview:maxLabel];
        }
        maxLabel.text = max;
    } else {
        [maxLabel removeFromSuperview]; 
        maxLabel = nil;
    }
}

- (void) sliderChanged:(UISlider*)sender {
    if (_object && _keyPath) {
        [_object setValue:[NSNumber numberWithFloat:sender.value] 
               forKeyPath:_keyPath];
        
        if (_showValue) {
            [self displayValue];
        }
    }
}

@end
