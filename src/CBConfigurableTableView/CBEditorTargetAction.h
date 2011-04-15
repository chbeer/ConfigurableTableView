//
//  CBEditorTargetAction.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.11.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBEditor.h"

@interface CBEditorTargetAction : CBEditor {
    id _target;
    SEL _selector;
}

+ (CBEditorTargetAction*) editorWithTarget:(id)target action:(SEL)selector;

@end
