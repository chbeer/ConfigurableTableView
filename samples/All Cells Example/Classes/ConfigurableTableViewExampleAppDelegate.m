//
//  ConfigurableTableViewExampleAppDelegate.m
//  ConfigurableTableViewExample
//
//  Created by Christian Beer on 04.12.09.
//  Copyright Christian Beer 2009. All rights reserved.
//

#import "ConfigurableTableViewExampleAppDelegate.h"
#import "RootViewController.h"


@implementation ConfigurableTableViewExampleAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

