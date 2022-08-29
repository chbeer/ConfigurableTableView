//
//  CBCellButtons.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 11.09.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCell.h"


@interface CBCellButtons : CBCell {
    NSMutableArray *_buttons;
}

- (UIButton*) addButtonWithTitle:(NSString*)title target:(id)target action:(SEL)action;

@end
