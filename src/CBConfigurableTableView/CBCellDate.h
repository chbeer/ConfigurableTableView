//
//  CBCellDate.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCell.h"

@interface CBCellDate : CBCell {
	NSDateFormatter *_dateFormatter;
}

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath dateStyle:(NSDateFormatterStyle)dateStyle;
+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath dateStyle:(NSDateFormatterStyle)dateStyle editor:(CBEditor*)editor;

+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath timeStyle:(NSDateFormatterStyle)timeStyle;
+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath timeStyle:(NSDateFormatterStyle)timeStyle editor:(CBEditor*)editor;

- (id) applyDateStyle:(NSDateFormatterStyle)dateStyle;
- (id) applyDateTime:(NSDateFormatterStyle)timeStyle;

@end
