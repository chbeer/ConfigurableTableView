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

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, copy) CBCellActionBlock actionBlock;

+ (id)cellWithTitle:(NSString *)title target:(id)target action:(SEL)selector;
+ (id)cellWithTitle:(NSString *)title actionBlock:(CBCellActionBlock)block;

@end
