//
//  CBCellCharacter.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.07.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellCharacter.h"

#import "CBCharacterTableViewCell.h"
#import "CBConfigurableTableViewController.h"

@implementation CBCellCharacter

#pragma mark CBCell protocol

/* Override! */
- (NSString*) reuseIdentifier {
	return @"CBCellCharacter";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	CBCharacterTableViewCell *cell = [[CBCharacterTableViewCell alloc] initWithReuseIdentifier:[self reuseIdentifier]];
	
	return cell;
}

- (void) setValue:(id)value ofCell:(CBCharacterTableViewCell *)cell inTableView:(UITableView *)tableView {
    cell.textField.text = value;
}

- (BOOL) hasEditor {
    return YES;
}

- (BOOL) isEditorInline {
    return YES;
}

- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
    [controller.tableView scrollToRowAtIndexPath:[controller.model indexPathOfCell:self]
                                atScrollPosition:UITableViewScrollPositionMiddle
                                        animated:YES];
}

@end
