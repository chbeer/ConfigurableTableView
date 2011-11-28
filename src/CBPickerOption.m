//
//  CBPickerOption.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBPickerOption.h"


@implementation CBPickerOption

@synthesize value = _value;
@synthesize label = _label;
@synthesize iconName = _iconName;

- (void)dealloc {
    self.value = nil;
    self.label = nil;
    self.iconName = nil;
    
    [super dealloc];
}

+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label iconName:(NSString *)iconName {
	CBPickerOption *o = [[CBPickerOption alloc] init];
	o.value = value;
	o.label = label;
    o.iconName = iconName;
	return [o autorelease];
}
+ (CBPickerOption*) optionWithValue:(NSObject*)value label:(NSString*)label {
	return [self optionWithValue:value label:label iconName:nil];
}

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ... {
    NSMutableArray *array = [NSMutableArray array];
    
    va_list args;
    va_start(args, firstValue);
    NSObject *v = firstValue;
    while (v) {
        NSString *l = va_arg(args, NSString *);
        [array addObject:[CBPickerOption optionWithValue:v label:l]];
        
        v = va_arg(args, NSObject *);
    }
	va_end(args);
    
    return array;
}

@end


CBPickerOption* CBPickerOptionMake(NSObject *value, NSString *label) {
    return [CBPickerOption optionWithValue:value label:label];
}
CBPickerOption* CBPickerOptionMakeWithIcon(NSObject *value, NSString *label, NSString *iconName) {
    return [CBPickerOption optionWithValue:value label:label iconName:iconName];
}
