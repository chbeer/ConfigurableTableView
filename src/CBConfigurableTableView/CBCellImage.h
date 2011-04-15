//
//  CBCellImage.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"

@interface CBCellImage : CBCell <UIActionSheetDelegate,UIImagePickerControllerDelegate> {
    CGFloat _maxHeight;
}

@property (nonatomic) CGFloat maxHeight;

@end
