//
//  CBConfigTableViewCell.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.07.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBConfigTableViewCell : UITableViewCell {
    id __weak _object;
	NSString *_keyPath;
}

@property (nonatomic, weak) id object;
@property (nonatomic, copy) NSString *keyPath;

@end
