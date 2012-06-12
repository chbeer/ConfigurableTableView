//
//  CBCellPerformSegue.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 15.04.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBCellPerformSegue.h"

@implementation CBCellPerformSegue

@synthesize segueIdentifier = _segueIdentifier;
@synthesize sender = _sender;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
        self.enabled = YES;
	}
	return self;
}

+ (id)cellWithTitle:(NSString *)title segueIdentifier:(NSString*)segueIdentifier sender:(id)sender {
	CBCellPerformSegue *cell = [[[self class] alloc] initWithTitle:title];
	
	cell.segueIdentifier = segueIdentifier;
	cell.sender = sender;
    
    cell.enabled = YES;
	
	return [cell autorelease];
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellPerformSegue";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
													reuseIdentifier:[self reuseIdentifier]];
	cell.textLabel.textAlignment = UITextAlignmentLeft;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] + 2];
    
    cell.textLabel.enabled = self.enabled;
	
	return [cell autorelease];
}
- (void)setupCell:(UITableViewCell *)cell withObject:(NSObject *)object inTableView:(UITableView *)tableView
{
    [super setupCell:cell withObject:object inTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (BOOL) hasEditor {
	return YES;
}
- (BOOL)isEditorInline
{
    return YES;
}

- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
    if (!self.enabled) return;
    
    id sender = self.sender ?: self;
    
    [controller performSelector:@selector(performSegueWithIdentifier:sender:) 
                     withObject:self.segueIdentifier withObject:sender];
}

@end
