//
//  CBCellPassword.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 06.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellPassword.h"


@implementation CBCellPassword

- (NSString*) reuseIdentifier {
	return @"CBCellPassword";
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	if (value && [value length] > 0) {
		cell.detailTextLabel.text = @"•••••••";
	} else {
		cell.detailTextLabel.text = @"";
	}
}

@end
