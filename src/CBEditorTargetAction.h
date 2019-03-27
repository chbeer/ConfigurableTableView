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

- (instancetype) initWithTarget:(id __nullable)target action:(SEL)selector;
+ (instancetype) editorWithTarget:(id __nullable)target action:(SEL)selector;

- (instancetype) applyHasDisclosureIndicator:(BOOL)hasDisclosureIndicator;

@end
