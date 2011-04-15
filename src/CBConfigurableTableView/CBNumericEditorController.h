//
//  CBNumericEditorController.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBStringEditorController.h"

@interface CBNumericEditorController : CBStringEditorController {

}

- (id) initWithValue:(NSNumber*)value andTitle:(NSString*)title;

@end
