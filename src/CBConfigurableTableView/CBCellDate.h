//
//  CBCellDate.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCell.h"

@interface CBCellDate : CBCell {
	NSDateFormatter *_dateFormatter;
}

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@end
