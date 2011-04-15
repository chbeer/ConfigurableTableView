//
//  CBCellBoolean.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"

@interface CBCellBoolean : CBCell {
	NSObject *_object;
	UISwitch *_switch;
    
    BOOL _inverted;
}

@property (nonatomic, assign, getter=isInverted) BOOL inverted;

- (CBCellBoolean*) applyInverted:(BOOL) inverted;

@end
