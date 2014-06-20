//
//  CBConfigurableTableView.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBTable.h"
#import "CBConfigurableDataSourceAndDelegate.h"

@interface CBConfigurableTableViewController : UITableViewController {
    BOOL _kbDidShow;    

    CBTable *_model;
}

@property (nonatomic, strong) CBConfigurableDataSourceAndDelegate *dataSource;

@property (nonatomic, strong) CBTable *model;
@property (nonatomic, strong) id data;

@property (nonatomic, assign) UITableViewRowAnimation addAnimation;
@property (nonatomic, assign) UITableViewRowAnimation removeAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadAnimation;


- (id)initWithTableModel:(CBTable*)model;
- (id)initWithTableModel:(CBTable*)model andData:(NSObject*)object;

- (void) setValue:(id)value forCell:(CBCell*)cell withReload:(BOOL)reload;
- (void) setValue:(id)value forCell:(CBCell*)cell;
- (id) valueForCell:(CBCell*)cell;

- (void) addKeyboardObservers;
- (void) removeKeyboardObservers;

@end
