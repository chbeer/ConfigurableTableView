//
//  SliderCell.m
//  VocabuTrainer
//
//  Created by Christian Beer on 25.11.08.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBSliderCell.h"

#import "CBCTVGlobal.h"


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

- (void) displayValue
{
    NSString *v = nil;
    if (_valueFormat) {
        v = [NSString stringWithFormat:_valueFormat, slider.value];
    } else {
        v = [NSString stringWithFormat:@"%f", slider.value];
    }
    self.detailTextLabel.text = v;
}
- (void) layoutSubviews
{
	[super layoutSubviews];
    
    CGRect contentRect = [self.contentView bounds];
    CGFloat contentWidth = contentRect.size.width - 2 * self.textLabel.frame.origin.x;
	
    [self.textLabel sizeToFit];
    self.textLabel.frame = ({
        CGRect rect = self.textLabel.frame;
        rect.origin.y = 10;
        rect.size.width = contentWidth;
        rect;
    });
	
	slider.frame = ({
        CGRect rect;
        if (self.textLabel.text) {
            rect = self.textLabel.frame;
            if (self.detailTextLabel.text) {
                rect.origin.y = CGRectGetMaxY(self.detailTextLabel.frame) + 4;
            } else {
                rect.origin.y = CGRectGetMaxY(self.textLabel.frame) + 4;
            }
        } else {
            rect = contentRect;
            rect.origin.y = 10;
            rect.origin.x += CBCTVIsIOS7() ? 15 : 10;
            rect.size.width -= CBCTVIsIOS7() ? 30 : 20;
        }
        rect.size.height = slider.bounds.size.height;
        rect;
    });
    [slider sizeToFit];
    
	if (minLabel && maxLabel) {
		float slFrameHalf = roundf(slider.frame.size.width / 2);
		CGRect minFrame = CGRectMake(slider.frame.origin.x,
									 CGRectGetMaxY(slider.frame) + 2,
									 slFrameHalf,
									 minLabel.frame.size.height);
		CGRect maxFrame = CGRectMake(slider.frame.origin.x + slFrameHalf,
									 CGRectGetMaxY(slider.frame) + 2,
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
