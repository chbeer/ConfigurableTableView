//
//  CBEditor.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"

@class CBConfigurableTableViewController;

@protocol CBEditorDelegate <NSObject>

- (void) editorWillBeClosed:(id)editor;
- (void) editor:(id)editor didChangeValue:(id)value;

@end


@protocol CBEditor <NSObject>

+ (CBEditor*) editor;

- (BOOL) isInline;

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl;

@optional

- (UITableViewCell*) cell:(CBCell*)cell didCreateTableViewCell:(UITableViewCell*)tableViewCell;
- (void) cell:(CBCell*)cell didSetupTableViewCell:(UITableViewCell*)tableViewCell withObject:(id)object inTableView:(UITableView*)tableView;

@end


@interface CBEditor : NSObject <CBEditor> {
}

+ (CBEditor*) editor;

- (BOOL) isInline;

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl;

@end
