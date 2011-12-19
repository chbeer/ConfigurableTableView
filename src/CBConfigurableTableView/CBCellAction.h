//
//  CBCellAction.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCell.h"

@interface CBCellAction : CBCell

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

+ (id)cellWithTitle:(NSString *)title target:(id)target action:(SEL)selector;

@end
