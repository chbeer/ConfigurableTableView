//
//  CBCellOptions.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 28.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellOptions.h"

#import "CBPickerOption.h"

@implementation CBCellOptions

- (id) initWithTitle:(NSString*)title andValuePath:(NSString*)valuePath andPickerOptions:(NSArray*)options {
	if (self = [super initWithTitle:title andValuePath:valuePath]) {
        
		self.style = title ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault;
		self.multiline = NO;
		
		NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
		for (CBPickerOption *o in options) {
			[d setObject:o forKey:(id)o.value];
		}
		_options = d;
	}
	return self;
}

+ (CBCellOptions*) cellWithTitle:(NSString*)title valuePath:(NSString*)valuePath pickerOptions:(NSArray*)options {
	CBCellOptions *cell = [[[self class] alloc] initWithTitle:title 
                                                 andValuePath:valuePath
                                             andPickerOptions:options];
	return [cell autorelease];
}

+ (CBCellOptions*) cellWithTitle:(NSString*)title valuePath:(NSString*)valuePath pickerOptions:(NSArray*)options editor:(CBEditor*)editor {
	CBCellOptions *cell = [[[self class] alloc] initWithTitle:title 
                                                 andValuePath:valuePath
                                             andPickerOptions:options];
	cell.editor = editor;
	return [cell autorelease];
}

- (CBCellOptions*) applyDefaultValue:(NSObject*) defaultValue;
{
    _defaultValue = defaultValue;
    
    return self;
}

- (void) dealloc
{
	[_options release], _options = nil;
    [_defaultValue release], _defaultValue = nil;
	
	[super dealloc];
}


#pragma mark CBCell protocol

- (void) setValue:(id)value 
		   ofCell:(UITableViewCell*)cell
	  inTableView:(UITableView*)tableView {
	value = [_options objectForKey:value];
    if (!value && _defaultValue) {
        value = [_options objectForKey:_defaultValue];
    }
	
    if (![value isKindOfClass:[CBPickerOption class]]) {
        [super setValue:value ofCell:cell inTableView:tableView];
    } else {
        CBPickerOption *option = value;
        [super setValue:option.label ofCell:cell inTableView:tableView];
        
        if (option.icon) {
            cell.imageView.image = option.icon;
        } else {
            cell.imageView.image = nil;
        }
    }
    
}

@end
