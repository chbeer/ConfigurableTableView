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
}

@property (nonatomic, retain) NSObject *value;
@property (nonatomic, copy) NSString *label;

+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label;

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ...;

@end


CBPickerOption* CBPickerOptionMake(NSObject *value, NSString *label);