//
//  CBPickerOption.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBPickerOption : NSObject

@property (nonatomic, strong)   id value;
@property (nonatomic, copy)     NSString *label;
@property (nonatomic, strong)   UIImage *icon;

@property (nonatomic, copy)     NSString *footerText;
@property (nonatomic, assign, getter= isEnabled) BOOL enabled;

+ (instancetype) optionWithValue:(id)value label:(NSString*)label;
+ (instancetype) optionWithValue:(id)value label:(NSString*)label icon:(UIImage*)icon;
+ (instancetype) optionWithValue:(id)value label:(NSString*)label iconName:(NSString*)iconName;
+ (instancetype) optionWithValue:(id)value label:(NSString*)label footerText:(NSString*)footerText;
+ (instancetype) optionWithValue:(id)value label:(NSString*)label footerText:(NSString*)footerText enabled:(BOOL)enabled;

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ...;

@end


CBPickerOption* CBPickerOptionMake(NSObject *value, NSString *label);
CBPickerOption* CBPickerOptionMakeWithIcon(NSObject *value, NSString *label, UIImage *icon);
CBPickerOption* CBPickerOptionMakeWithIconName(NSObject *value, NSString *label, NSString *iconName);