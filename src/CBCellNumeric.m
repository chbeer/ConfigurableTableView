//
//  CBCellNumeric.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellNumeric.h"


@implementation CBCellNumeric

@synthesize numberFormatter = _numberFormatter;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
		_numberFormatter = [[NSNumberFormatter alloc] init];
		[_numberFormatter setGeneratesDecimalNumbers:NO];
        
        self.style = UITableViewCellStyleValue1;
	}
	return self;
}

- (void) dealloc {
	[_numberFormatter release];
	
	[super dealloc];
}

#pragma mark CBCell protocol

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	if (value && [value isKindOfClass:[NSNumber class]]) {
		cell.detailTextLabel.text = [_numberFormatter stringFromNumber:(NSNumber*)value];
	} else {
		cell.detailTextLabel.text = @"!";
	}
}

@end
