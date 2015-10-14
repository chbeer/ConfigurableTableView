//
//  CBTableViewCell.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CBConfigurableTableViewController;
@class CBEditor;
@class CBEditorController;
@class CBSection;
@class CBCell;


typedef id(^CBCellValueTransformerHandler)(id value);
typedef void(^CBCellAccessoryButtonHandler)(CBCell *cell, UITableView *tableView, NSIndexPath *indexPath);


@protocol CBCell <NSObject>

- (NSString*) title;

- (NSString*) reuseIdentifier;
- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView;

/** Use this to update the value in the tableViewCell */
- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView;
/** Use this to setup the TableViewCell. Needs only overridden for special cells. 
 * Otherwise override setValue:ofCell: */
- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView;

- (BOOL) hasEditor;
- (BOOL) isEditorInline;
- (void) openEditorInController:(CBConfigurableTableViewController*)controller fromTableViewCell:(UITableViewCell*)cell;
- (void) openEditorInController:(CBConfigurableTableViewController*)controller;
- (void) setEditor:(CBEditor*)editor;

@optional

- (CGFloat) heightForCell:(CBCell*)cell atIndexPath:(NSIndexPath*)indexPath inTableView:(UITableView*)tableView withObject:(NSObject*)object;
- (CGFloat) heightForCell:(CBCell*)cell inTableView:(UITableView*)tableView withObject:(NSObject*)object;
- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object;

- (UITableViewCellStyle) tableViewCellStyle;
- (Class) tableViewCellClass;

@end


@interface CBCell : NSObject <CBCell>

@property (nonatomic, weak) CBConfigurableTableViewController *controller;
@property (nonatomic, weak) CBSection* section;

@property (nonatomic, assign) UITableViewCellStyle style;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *valueKeyPath;
@property (nonatomic, copy) NSString *accessibilityLabel;

@property (weak, readonly) NSString *reuseIdentifier;

@property (nonatomic, copy) NSString *nibReuseIdentifier;

@property (nonatomic, strong) CBEditor *editor;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *detailFont;

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

@property (nonatomic, copy) CBCellValueTransformerHandler valueTransformerHandler;
@property (nonatomic, copy) CBCellAccessoryButtonHandler  accessoryButtonHandler;

- (instancetype) initWithTitle:(NSString*)title;
- (instancetype) initWithTitle:(NSString*)title andValuePath:(NSString*)valueKeyPath;

+ (instancetype) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath;
+ (instancetype) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath editor:(CBEditor*)editor;
+ (instancetype) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath iconName:(NSString*)iconName;
+ (instancetype) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath
                      iconName:(NSString*)iconName editor:(CBEditor*)editor;

+ (instancetype) cellWithNibReuseIdentifier:(NSString*)nibReuseIdentifier valuePath:(NSString*)valuePath;

- (instancetype) applyTag:(NSString *)tag;
- (instancetype) applyEditor:(CBEditor *)editor;
- (instancetype) applyFont:(UIFont*)font;
- (instancetype) applyDetailFont:(UIFont*)font;
- (instancetype) applyIcon:(UIImage*)icon;
- (instancetype) applyIconName:(NSString*)iconName;
- (instancetype) applyStyle:(UITableViewCellStyle)style;
- (instancetype) applyEnabled:(BOOL)enabled;
- (instancetype) applyAccessibilityLabel:(NSString*)accessibilityLabel;
- (instancetype) applyValueTransformer:(CBCellValueTransformerHandler)valueTransformerHandler;
- (instancetype) applyAccessoryButtonHandler:(CBCellAccessoryButtonHandler) accessoryButtonHandler;

- (instancetype) applyNibReuseIdentifier:(NSString*)reuseIdentifier;

- (UITableViewCellAccessoryType) accessoryType;

@end
