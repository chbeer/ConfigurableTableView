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


typedef id _Nullable (^CBCellValueTransformerHandler)(id _Nullable value);
typedef void(^CBCellDidSetValueHandler)(id _Nullable value, CBCell * _Nonnull cell, UIViewController * _Nonnull dataSource);
typedef void(^CBCellAccessoryButtonHandler)(CBCell * _Nonnull cell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath);


@protocol CBCell <NSObject>

- (NSString* _Nullable) title;

- (NSString* _Nonnull) reuseIdentifier;
- (UITableViewCell* _Nonnull) createTableViewCellForTableView:(UITableView* _Nonnull)tableView;

/** Use this to update the value in the tableViewCell */
- (void) setValue:(id _Nullable)value ofCell:(UITableViewCell* _Nonnull)cell inTableView:(UITableView* _Nonnull)tableView;
/** Use this to setup the TableViewCell. Needs only overridden for special cells. 
 * Otherwise override setValue:ofCell: */
- (void) setupCell:(UITableViewCell* _Nonnull)cell withObject:(NSObject* _Nullable)object inTableView:(UITableView* _Nonnull)tableView;

- (BOOL) hasEditor;
- (BOOL) isEditorInline;
- (void) openEditorInController:(UIViewController* _Nonnull)controller fromTableViewCell:(UITableViewCell* _Nonnull)cell;
- (void) openEditorInController:(UIViewController* _Nonnull)controller;
- (void) setEditor:(CBEditor* _Nullable)editor;

@optional

- (CGFloat) heightForCell:(CBCell* _Nonnull)cell atIndexPath:(NSIndexPath* _Nonnull)indexPath inTableView:(UITableView* _Nonnull)tableView withObject:(NSObject*)object;
- (CGFloat) heightForCell:(CBCell* _Nonnull)cell inTableView:(UITableView* _Nonnull)tableView withObject:(NSObject* _Nullable)object;
- (CGFloat) heightForCellInTableView:(UITableView* _Nonnull)tableView withObject:(NSObject* _Nullable)object;

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

@property (nonatomic, readonly) NSString * _Nonnull reuseIdentifier;

@property (nonatomic, copy) NSString *nibReuseIdentifier;

@property (nonatomic, strong) CBEditor *editor;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *detailFont;

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *iconName;

@property (nonatomic, assign, getter=isEnabled) BOOL enabled;
@property (nonatomic, readonly, getter=isHidden) BOOL hidden;

@property (nonatomic, copy) CBCellValueTransformerHandler valueTransformerHandler;
@property (nonatomic, copy) CBCellDidSetValueHandler didSetValueHandler;
@property (nonatomic, copy) CBCellAccessoryButtonHandler  accessoryButtonHandler;

- (instancetype _Nonnull) initWithTitle:(NSString* _Nullable)title;
- (instancetype _Nonnull) initWithTitle:(NSString* _Nullable)title andValuePath:(NSString* _Nullable)valueKeyPath;

+ (instancetype _Nonnull) cellWithTitle:(NSString* _Nullable)title valuePath:(NSString* _Nullable)valueKeyPath;
+ (instancetype _Nonnull) cellWithTitle:(NSString* _Nullable)title valuePath:(NSString* _Nullable)valueKeyPath editor:(CBEditor* _Nullable)editor;
+ (instancetype _Nonnull) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath iconName:(NSString*)iconName;
+ (instancetype _Nonnull) cellWithTitle:(NSString*)title valuePath:(NSString*)valueKeyPath
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
- (instancetype) applyHidden:(BOOL)hidden;
- (instancetype) applyAccessibilityLabel:(NSString*)accessibilityLabel;
- (instancetype) applyValueTransformer:(CBCellValueTransformerHandler)valueTransformerHandler;
- (instancetype) applyAccessoryButtonHandler:(CBCellAccessoryButtonHandler) accessoryButtonHandler;
- (instancetype) applyDidSetValueHandler:(CBCellDidSetValueHandler) didSetValueHandler;

- (instancetype) applyNibReuseIdentifier:(NSString*)reuseIdentifier;

- (UITableViewCellAccessoryType) accessoryType;

@end
