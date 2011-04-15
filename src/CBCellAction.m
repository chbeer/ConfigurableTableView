//
//  CBCellAction.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellAction.h"

@implementation CBCellAction

@synthesize target = _target;
@synthesize action = _action;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
	}
	return self;
}

+ (CBCell*)cellWithTitle:(NSString *)title target:(id)target action:(SEL)action {
	CBCellAction *cell = [[[self class] alloc] initWithTitle:title];
	
	cell.target = target;
	cell.action = action;
	
	return [cell autorelease];
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellAction";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
													reuseIdentifier:[self reuseIdentifier]];
	cell.textLabel.textColor = [UIColor blueColor];
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	
	return [cell autorelease];
}

- (BOOL) hasEditor {
	return _target != nil;
}

- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
	if (_target) {
		[_target performSelector:_action withObject:self];
	}
}

@end
