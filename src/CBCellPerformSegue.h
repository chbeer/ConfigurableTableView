//
//  CBCellPerformSegue.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 15.04.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBCell.h"

@interface CBCellPerformSegue : CBCell

@property (nonatomic, copy) NSString *segueIdentifier;
@property (nonatomic, retain) id sender;

+ (id)cellWithTitle:(NSString *)title segueIdentifier:(NSString*)segueIdentifier sender:(id)sender;

@end
