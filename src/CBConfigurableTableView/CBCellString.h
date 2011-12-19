//
//  CBCellString.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"

@interface CBCellString : CBCell 

@property (nonatomic, assign) BOOL multiline;
@property (nonatomic, retain) UIFont *font;

+ (id) cellMultilineWithValuePath:(NSString*)path;

- (id)applyFont:(UIFont*)font;
- (id)applyMultiline;

#pragma mark private

- (CGFloat) calculateHeightForCellInTableView:(UITableView*)tableView withText:(NSString*)text;

@end
