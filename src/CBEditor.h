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
@class CBConfigurableDataSourceAndDelegate;

@protocol CBEditorDelegate <NSObject>

- (void) editorWillBeClosed:(id)editor;
- (void) editor:(id)editor didChangeValue:(id)value;

@end


@protocol CBEditor <NSObject>

+ (instancetype) editor;

- (BOOL) isInline;

- (void) openEditorForCell:(CBCell*)cell inController:(UIViewController*)ctrl;

@optional

- (UITableViewCell*) cell:(CBCell*)cell didCreateTableViewCell:(UITableViewCell*)tableViewCell;
- (void) cell:(CBCell*)cell didSetupTableViewCell:(UITableViewCell*)tableViewCell withObject:(id)object inTableView:(UITableView*)tableView;

- (CGSize) editorAccessorySize;

- (void) configurableDataSource:(CBConfigurableDataSourceAndDelegate*)dataSource cell:(CBCell*)cell accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath;

@end


@interface CBEditor : NSObject <CBEditor> {
}

+ (instancetype) editor;

- (BOOL) isInline;
- (CGSize) editorAccessorySize;

- (void) openEditorForCell:(CBCell*)cell inController:(UIViewController*)ctrl;

@end
