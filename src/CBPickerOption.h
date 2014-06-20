//
//  CBPickerOption.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBPickerOption : NSObject {
	NSObject *_value;
	NSString *_label;
    
    UIImage *_icon;
}

@property (nonatomic, strong)   NSObject *value;
@property (nonatomic, copy)     NSString *label;
@property (nonatomic, strong)   UIImage *icon;

+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label;
+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label icon:(UIImage*)icon;
+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label iconName:(NSString*)iconName;

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ...;

@end


CBPickerOption* CBPickerOptionMake(NSObject *value, NSString *label);
CBPickerOption* CBPickerOptionMakeWithIcon(NSObject *value, NSString *label, UIImage *icon);
CBPickerOption* CBPickerOptionMakeWithIconName(NSObject *value, NSString *label, NSString *iconName);