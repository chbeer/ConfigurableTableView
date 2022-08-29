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
    
    UIActivityIndicatorView *_activityView;    
}

@property (nonatomic, assign, getter=isInverted) BOOL inverted;

- (id) applyInverted:(BOOL) inverted;

- (void) setWorking:(BOOL)working;

@end
