//
//  CBPickerOption.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBPickerOption : NSObject {
	NSObject *_value;
	NSString *_label;
    
    NSString *_iconName;
}

@property (nonatomic, retain) NSObject *value;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *iconName;

+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label;
+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label iconName:(NSString*)iconName;

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ...;

@end


CBPickerOption* CBPickerOptionMake(NSObject *value, NSString *label);
CBPickerOption* CBPickerOptionMakeWithIcon(NSObject *value, NSString *label, NSString *iconName);