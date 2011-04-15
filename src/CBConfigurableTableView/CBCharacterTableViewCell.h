//
//  CBCharacterTableViewCell.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.07.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBConfigTableViewCell.h"

@interface CBCharacterTableViewCell : CBConfigTableViewCell {
    UITextField *_textField;
}

@property (nonatomic, readonly) UITextField *textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
