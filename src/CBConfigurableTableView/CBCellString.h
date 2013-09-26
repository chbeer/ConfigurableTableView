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

@property (nonatomic, copy) CBCellValueTranslationBLock valueTranslation;

+ (id) cellMultilineWithValuePath:(NSString*)path;

- (id)applyMultiline;

#pragma mark private

- (CGFloat) calculateHeightForCell:(CBCell*)cell inTableView:(UITableView*)tableView withText:(NSString*)text;

@end
