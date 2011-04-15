//
//  CBConfigurableTableView.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBTable.h"

@interface CBConfigurableTableViewController : UIViewController <CBTableDelegate,UITableViewDataSource,UITableViewDelegate> {
	UITableView *_tableView;
	
	id _data;
	
	CBTable *_model;

    BOOL _kbDidShow;    

    UITableViewRowAnimation _addAnimation;
    UITableViewRowAnimation _removeAnimation;
    UITableViewRowAnimation _reloadAnimation;
    
}

@property (readonly) UITableView *tableView;

@property (nonatomic, retain) CBTable *model;
@property (nonatomic, retain) id data;

@property (nonatomic, assign) UITableViewRowAnimation addAnimation;
@property (nonatomic, assign) UITableViewRowAnimation removeAnimation;


- (id) initWithStyle:(UITableViewStyle)style;
- (id)initWithTableModel:(CBTable*)model;
- (id)initWithTableModel:(CBTable*)model andData:(NSObject*)object;

- (void) setValue:(id)value forCell:(CBCell*)cell;
- (id) valueForCell:(CBCell*)cell;

@end
