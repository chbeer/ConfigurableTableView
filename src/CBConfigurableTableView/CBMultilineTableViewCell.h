//
//  CBMultilineTableViewCell.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBCell.h"
#import "CBConfigTableViewCell.h"

@interface CBMultilineTableViewCell : CBConfigTableViewCell {
}

+ (CGFloat) calculateHeightInTableView:(UITableView*)tableView withText:(NSString*)text 
							   andFont:(UIFont*)font;

@end
