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
    __weak id _target;
    SEL _selector;
    
    BOOL _inline;
}

+ (id) editorWithTarget:(id)target action:(SEL)selector;

- (id) applyHasDisclosureIndicator:(BOOL)hasDisclosureIndicator;

@end
