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

@property (weak, readonly) NSArray<CBCell*> *cells;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIView *footerView;

- (instancetype _Nonnull) initWithTitle:(NSString* _Nullable)title andCells:(NSArray<CBCell*>*)cells;
- (instancetype _Nonnull) initWithTitle:(NSString* _Nullable)title;

- (instancetype _Nonnull) applyTag:(NSString * _Nonnull)tag;

+ (instancetype _Nonnull) sectionWithTitle:(NSString* _Nullable)title;
+ (instancetype _Nonnull) sectionWithTitle:(NSString* _Nullable)title andCells:(CBCell*)cell, ...NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) visibleCellCount;
- (CBCell*) visibleCellAtIndex:(NSUInteger)idx;
- (NSUInteger) indexOfVisibleCell:(CBCell*)cell;
- (NSUInteger) indexOfVisibleCellWithTag:(NSString*)tag;

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

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndex:(NSInteger)index controller:(UIViewController*)ctrl object:(id)object;

@end
