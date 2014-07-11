//
//  CBConfigurableDataSourceAndDelegate.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.04.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBTable.h"

@interface CBConfigurableDataSourceAndDelegate : NSObject <CBTableDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic, strong) CBTable *model;
@property (nonatomic, strong) id data;

@property (nonatomic, assign) UITableViewRowAnimation addAnimation;
@property (nonatomic, assign) UITableViewRowAnimation removeAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadAnimation;

@property (nonatomic, assign) BOOL endEditingWhenScrolled;

- (id) initWithTableView:(UITableView*)tableView;


#pragma mark Value access

- (void) setValue:(id)value forCell:(CBCell*)cell withReload:(BOOL)reload;
- (void) setValue:(id)value forCell:(CBCell*)cell;
- (id) valueForCell:(CBCell*)cell;

@end
