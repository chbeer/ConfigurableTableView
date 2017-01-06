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
	CBConfigurableTableViewController *__weak _controller;
	CBTable *__weak _table;
    
    NSString *_tag;
	
	NSString *_title;
	
	NSMutableArray *_cells;

	UIView *_headerView;
    
    NSString *_footerTitle;
	UIView *_footerView;
}

@property (nonatomic, weak) CBConfigurableTableViewController *controller;
@property (nonatomic, weak) CBTable *table;

@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *title;

@property (weak, readonly) NSArray *cells;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIView *footerView;

- (instancetype) initWithTitle:(NSString*)title andCells:(NSArray*)cells;
- (instancetype) initWithTitle:(NSString*)title;

- (instancetype) applyTag:(NSString *)tag;

+ (instancetype) sectionWithTitle:(NSString*)title;
+ (instancetype) sectionWithTitle:(NSString*)title andCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) cellCount;
- (CBCell*) cellAtIndex:(NSUInteger)idx;
- (NSUInteger) indexOfCell:(CBCell*)cell;
- (NSUInteger) indexOfCellWithTag:(NSString*)tag;
- (CBCell*) addCell:(CBCell*)cell;
- (CBCell*) insertCell:(CBCell*)cell atIndex:(NSUInteger)index;
- (void) insertCells:(NSArray*)cells atIndex:(NSUInteger)index;
- (void) addCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;
- (void) addCellsFromArray:(NSArray*)cells;

- (CBCell*) cellWithTag:(NSString*)tag;
- (CBCell*) cellWithValueKeyPath:(NSString*)valuePath;

- (CBCell*) removeCell:(CBCell*)cell;
- (void) removeCellsInArray:(NSArray*)cells;
- (void) removeCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;
- (CBCell*) removeCellWithTag:(NSString*)cellTag;

- (void) setHidden:(BOOL)hidden tellDelegate:(BOOL)delegate;

@end
