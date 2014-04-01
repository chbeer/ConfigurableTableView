//
//  CBCellOptions.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 28.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCellString.h"

@interface CBCellOptions : CBCellString {
	
	NSDictionary *_options;
    
    id _defaultValue;

}

+ (CBCellOptions*) cellWithTitle:(NSString*)title valuePath:(NSString*)valuePath pickerOptions:(NSArray*)options;
+ (CBCellOptions*) cellWithTitle:(NSString*)title valuePath:(NSString*)valuePath pickerOptions:(NSArray*)options editor:(CBEditor*)editor;

- (CBCellOptions*) applyDefaultValue:(id)defaultValue;

@end
