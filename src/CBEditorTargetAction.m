//
//  CBEditorTargetAction.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.11.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorTargetAction.h"


@implementation CBEditorTargetAction

- (id) initWithTarget:(id)target action:(SEL)selector {
	if (self = [super init]) {
		_target = target;
        _selector = selector;
	}
	return self;
}

+ (CBEditorTargetAction*) editorWithTarget:(id)target action:(SEL)selector {
	CBEditorTargetAction *editor = [[[self class] alloc] initWithTarget:target action:selector];
	return [editor autorelease];
}

- (BOOL) isInline {
    return NO;
}

- (void) cell:(CBCell*)cell didSetupTableViewCell:(UITableViewCell*)tableViewCell withObject:(id)object inTableView:(UITableView*)tableView {
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleBlue;
}

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl {
	[_target performSelector:_selector];
}

@end
