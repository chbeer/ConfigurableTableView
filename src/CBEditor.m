//
//  CBEditor.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditor.h"

@implementation CBEditor

+ (instancetype) editor {
	CBEditor *editor = [[[self class] alloc] init];
	return editor;
}

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl {
}

- (BOOL) isInline {
	return YES;
}

- (CGSize) editorAccessorySize
{
    return CGSizeZero;
}

@end
