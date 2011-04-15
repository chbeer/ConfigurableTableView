//
//  CBEditorOpenLink.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.06.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBEditorOpenURL.h"


@implementation CBEditorOpenURL

@synthesize url = _url;


- (id) initWithURL:(NSURL*)url {
	if (self = [super init]) {
		self.url = url;
	}
	return self;
}

+ (CBEditorOpenURL*) editorWithURL:(NSURL*)url {
	CBEditorOpenURL *editor = [[[self class] alloc] initWithURL:url];
	return [editor autorelease];
}


- (void) dealloc {
    [_url release], _url = nil;
    
    [super dealloc];
}

- (void) openEditorForCell:(CBCell*)cell inController:(CBConfigurableTableViewController*)ctrl {
	[[UIApplication sharedApplication] openURL:_url];
}


@end
