//
//  CBImageEditorController.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBEditorController.h"

@interface CBImageEditorController : UIViewController <CBEditorController,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> {
	CBCell *_cell;	
	CBConfigurableTableViewController *_controller;	
	
	UIScrollView *_scrollView;
	UIImageView *_imageView;
	UIToolbar *_toolBar;
}

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller;

@end
