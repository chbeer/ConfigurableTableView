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
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] + 4];
	
	return [cell autorelease];
}
- (void)setupCell:(UITableViewCell *)cell withObject:(NSObject *)object inTableView:(UITableView *)tableView
{
    [super setupCell:cell withObject:object inTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
}

- (BOOL) hasEditor {
	return YES;
}
- (BOOL)isEditorInline
{
    return YES;
}

- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
    [[UIApplication sharedApplication] sendAction:self.action to:self.target from:self forEvent:nil];
}

@end
