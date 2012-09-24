//
//  CBPickerEditor.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEditor.h"


@interface CBEditorPicker : CBEditor {
	NSMutableArray *_options;
}

- (id) initWithOptions:(NSArray*)options;

+ (id) editorWithOptions:(NSArray*)options;

@end
