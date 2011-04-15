//
//  CBTableViewGroup.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CBConfigurableTableViewController;
@class CBTable;
@class CBSection;
@class CBCell;

@protocol CBSectionHeaderView

- (CGFloat) heightForHeaderInTableView:(UITableView*)tableView;

@end


@interface CBSection : NSObject {
	CBConfigurableTableViewController *_controller;
	CBTable *_table;
    
    NSString *_tag;
	
	NSString *_title;
	
	NSMutableArray *_cells;

	UIView *_headerView;
    
    NSString *_footerTitle;
	UIView *_footerView;
}

@property (nonatomic, assign) CBConfigurableTableViewController *controller;
@property (nonatomic, assign) CBTable *table;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *title;

@property (readonly) NSArray *cells;

@property (nonatomic, retain) UIView *headerView;

@property (nonatomic, retain) NSString *footerTitle;
@property (nonatomic, retain) UIView *footerView;

- (id) initWithTitle:(NSString*)title andCells:(NSArray*)cells;
- (id) initWithTitle:(NSString*)title;

- (CBSection*) applyTag:(NSString *)tag;

+ (CBSection*) sectionWithTitle:(NSString*)title;
+ (CBSection*) sectionWithTitle:(NSString*)title andCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) cellCount;
- (CBCell*) cellAtIndex:(NSUInteger)idx;
- (NSUInteger) indexOfCell:(CBCell*)cell;
- (CBCell*) addCell:(CBCell*)cell;
- (CBCell*) insertCell:(CBCell*)cell atIndex:(NSUInteger)index;
- (void) addCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;
- (void) addCellsFromArray:(NSArray*)cells;

- (CBCell*) cellWithTag:(NSString*)tag;

- (CBCell*) removeCell:(CBCell*)cell;
- (void) removeCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;

@end
