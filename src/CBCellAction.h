//
//  CBCellAction.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCell.h"

typedef void(^CBCellActionBlock)(void);

@interface CBCellAction : CBCell

@property (nonatomic, weak) id _Nullable target;
@property (nonatomic, assign) SEL _Nullable action;

@property (nonatomic, copy) CBCellActionBlock _Nullable actionBlock;

@property (nonatomic, assign) NSTextAlignment               textAlignment;
@property (nonatomic, assign) UITableViewCellAccessoryType  cellAccessoryType;

- (instancetype _Nonnull)initWithTitle:(NSString * _Nullable)title target:(id _Nullable)target action:(SEL _Nonnull)selector;
- (instancetype _Nonnull)initWithTitle:(NSString * _Nullable)title actionBlock:(CBCellActionBlock _Nonnull)block;

+ (instancetype _Nonnull)cellWithTitle:(NSString * _Nullable)title target:(id _Nullable)target action:(SEL _Nonnull)selector;
+ (instancetype _Nonnull)cellWithTitle:(NSString * _Nullable)title actionBlock:(CBCellActionBlock _Nonnull)block;

- (instancetype _Nonnull) applyTextAlignment:(NSTextAlignment)textAlignment;
- (instancetype _Nonnull) applyTableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType;

@end
