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

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, copy) CBCellActionBlock actionBlock;

@property (nonatomic, assign) NSTextAlignment               textAlignment;
@property (nonatomic, assign) UITableViewCellAccessoryType  cellAccessoryType;

+ (instancetype)cellWithTitle:(NSString *)title target:(id)target action:(SEL)selector;
+ (instancetype)cellWithTitle:(NSString *)title actionBlock:(CBCellActionBlock)block;

- (instancetype) applyTextAlignment:(NSTextAlignment)textAlignment;
- (instancetype) applyTableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType;

@end
