//
//  CBCellString.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"


typedef NSString*(^CBCellValueTranslationBLock)(id value);


@interface CBCellString : CBCell 

@property (nonatomic, assign) BOOL multiline;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIFont *detailFont;

@property (nonatomic, copy) CBCellValueTranslationBLock valueTranslation;

+ (id) cellMultilineWithValuePath:(NSString*)path;

- (id)applyFont:(UIFont*)font;
- (id)applyDetailFont:(UIFont*)font;
- (id)applyMultiline;

#pragma mark private

- (CGFloat) calculateHeightForCell:(CBCell*)cell inTableView:(UITableView*)tableView withText:(NSString*)text;

@end
