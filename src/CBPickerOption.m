//
//  CBPickerOption.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBPickerOption.h"


@implementation CBPickerOption

+ (instancetype) optionWithValue:(id)value label:(NSString*)label icon:(UIImage *)icon footerText:(NSString*)footerText enabled:(BOOL)enabled;
{
    CBPickerOption *o = [CBPickerOption new];
    o.value = value;
    o.label = label;
    o.icon = icon;
    o.footerText = footerText;
    o.enabled = enabled;
    return o;
}
+ (instancetype) optionWithValue:(id)value label:(NSString*)label footerText:(NSString*)footerText enabled:(BOOL)enabled;
{
    return [self optionWithValue:value label:label icon:nil footerText:footerText enabled:enabled];
}
+ (instancetype) optionWithValue:(id)value label:(NSString*)label footerText:(NSString*)footerText;
{
    return [self optionWithValue:value label:label footerText:footerText enabled:YES];
}
+ (instancetype) optionWithValue:(id)value label:(NSString*)label icon:(UIImage *)icon
{
    return [self optionWithValue:value label:label icon:icon footerText:nil enabled:YES];
}
+ (instancetype) optionWithValue:(id)value label:(NSString*)label iconName:(NSString *)iconName
{
    UIImage *image = [UIImage imageNamed:iconName];
    return [self optionWithValue:value label:label icon:image];
}
+ (instancetype) optionWithValue:(NSObject*)value label:(NSString*)label
{
	return [self optionWithValue:value label:label icon:nil];
}

+ (NSArray*) arrayWithPickerOptionsValuesAndLabels:(NSObject*)firstValue, ...
{
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
CBPickerOption* CBPickerOptionMakeWithIcon(NSObject *value, NSString *label, UIImage *icon) {
    return [CBPickerOption optionWithValue:value label:label icon:icon];
}
CBPickerOption* CBPickerOptionMakeWithIconName(NSObject *value, NSString *label, NSString *iconName) {
    return [CBPickerOption optionWithValue:value label:label iconName:iconName];
}
