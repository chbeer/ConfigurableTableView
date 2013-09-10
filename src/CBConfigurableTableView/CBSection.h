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

@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *title;

@property (readonly) NSArray *cells;

@property (nonatomic, retain) UIView *headerView;

@property (nonatomic, retain) NSString *footerTitle;
@property (nonatomic, retain) UIView *footerView;

- (id) initWithTitle:(NSString*)title andCells:(NSArray*)cells;
- (id) initWithTitle:(NSString*)title;

- (CBSection*) applyTag:(NSString *)tag;

+ (id) sectionWithTitle:(NSString*)title;
+ (id) sectionWithTitle:(NSString*)title andCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) cellCount;
- (id) cellAtIndex:(NSUInteger)idx;
- (NSUInteger) indexOfCell:(CBCell*)cell;
- (NSUInteger) indexOfCellWithTag:(NSString*)tag;
- (id) addCell:(CBCell*)cell;
- (id) insertCell:(CBCell*)cell atIndex:(NSUInteger)index;
- (void) insertCells:(NSArray*)cells atIndex:(NSUInteger)index;
- (void) addCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;
- (void) addCellsFromArray:(NSArray*)cells;

- (id) cellWithTag:(NSString*)tag;
- (id) cellWithValueKeyPath:(NSString*)valuePath;

- (id) removeCell:(CBCell*)cell;
- (void) removeCellsInArray:(NSArray*)cells;
- (void) removeCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;
- (id) removeCellWithTag:(NSString*)cellTag;

@end
