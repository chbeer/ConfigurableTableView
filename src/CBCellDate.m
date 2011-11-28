//
//  CBCellDate.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellDate.h"


@implementation CBCellDate

@synthesize dateFormatter = _dateFormatter;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
		_dateFormatter = [[NSDateFormatter alloc] init];
		[_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	}
	return self;
}

- (void) dealloc {
	[_dateFormatter release];
	
	[super dealloc];
}

#pragma mark CBCell protocol

- (UITableViewCellStyle) tableViewCellStyle {
    return UITableViewCellStyleValue1;
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	if (value && [value isKindOfClass:[NSDate class]]) {
		cell.detailTextLabel.text = [_dateFormatter stringFromDate:(NSDate*)value];
	} else {
		cell.detailTextLabel.text = @"";
	}
}

@end
