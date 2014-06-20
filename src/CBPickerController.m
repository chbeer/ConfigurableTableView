//
//  CBSelectorEditor.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBPickerController.h"

#import "CBConfigurableTableViewController.h"

@interface CBPickerController (Private)

- (void) closeEditor;

@end


@implementation CBPickerController

- (id) init {
	if (self = [super init]) {
		CGRect screen = [UIScreen mainScreen].bounds;
		
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screen.size.height - 244, screen.size.width, 44)];
		UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																				   target:self action:@selector(cancel:)];
		UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				target:NULL action:NULL];
		UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																				 target:self action:@selector(done:)];
		
		[_toolbar setItems:[NSArray arrayWithObjects:cancelBtn, spacer, doneBtn, nil] animated:NO];
		
		
		[self.view addSubview:_toolbar];
		
	}
	return self;
}



- (IBAction)cancel:(id)sender {
	[self closeEditor];
}

#pragma mark -

- (void) layout {
	_picker.frame = CGRectMake(0, self.view.bounds.size.height - _picker.bounds.size.height, 
							   self.view.bounds.size.width, _picker.bounds.size.height);
	_toolbar.frame = CGRectMake(0, self.view.bounds.size.height - _picker.bounds.size.height - _toolbar.bounds.size.height, 
								self.view.bounds.size.width, _toolbar.bounds.size.height);
}

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller {
	[super openEditorForCell:cell inController:controller];
	
    if (controller.tabBarController) {
        self.view.frame = controller.tabBarController.view.bounds;
	} else if (controller.navigationController) {
        self.view.frame = controller.navigationController.view.bounds;
	} else {
        self.view.frame = controller.view.bounds;
	}
    
	[self layout];
    
	if (controller.tabBarController) {
		[controller.tabBarController.view addSubview:self.view];
	} else if (controller.navigationController) {
		[controller.navigationController.view addSubview:self.view];
	} else {
		[controller.view addSubview:self.view];
	}
    
    self.view.alpha = 0.0;
	
	[UIView beginAnimations:@"picker" context:nil];
	
    self.view.alpha = 1.0;
    
	CGRect tvf = controller.tableView.frame;
	tvf.size.height -= _picker.frame.size.height + _toolbar.frame.size.height;
	if (controller.tabBarController.tabBar) {
		tvf.size.height += controller.tabBarController.tabBar.bounds.size.height;
	}
	// status bar
	tvf.size.height += 20;
	
	controller.tableView.frame = tvf;	
	
	[controller.tableView scrollToRowAtIndexPath:[controller.tableView indexPathForSelectedRow] 
								atScrollPosition:UITableViewScrollPositionMiddle 
										animated:YES];
    
	[UIView commitAnimations];
}

- (void) closeEditor {
	[UIView beginAnimations:@"picker" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeAnimationDidStop:finished:context:)];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
	self.view.alpha = 0.0;
    
	CGRect tvf = _controller.tableView.frame;
	tvf.size.height += _picker.frame.size.height + _toolbar.frame.size.height;
	if (_controller.tabBarController.tabBar) {
		tvf.size.height -= _controller.tabBarController.tabBar.bounds.size.height;
	}
	// status bar
	tvf.size.height -= 20;
	
	_controller.tableView.frame = tvf;
	
	[UIView commitAnimations];
}
 - (void)closeAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self.view removeFromSuperview];
	
	[_controller.tableView deselectRowAtIndexPath:[_controller.tableView indexPathForSelectedRow]
                                         animated:YES];
}

- (BOOL) setSelectedValue:(id)value {
	// override in subclass!!!
	return NO;
}

@end
