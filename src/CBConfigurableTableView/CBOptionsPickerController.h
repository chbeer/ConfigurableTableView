//
//  CBOptionsPickerController.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBPickerController.h"

@interface CBOptionsPickerController : CBPickerController <UIPickerViewDataSource, UIPickerViewDelegate> {
	
	NSMutableArray *_options;
	
}

- (id) initWithOptions:(NSArray*)options frame:(CGRect)frame;
- (id) initWithOptions:(NSArray*)options;

@end
