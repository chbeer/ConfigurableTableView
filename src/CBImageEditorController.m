//
//  CBImageEditorController.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBImageEditorController.h"

#import "CBCTVGlobal.h"

#import "CBConfigurableTableViewController.h"

@interface CBImageEditorController (Private)

- (BOOL) canTakePicture;

-(void)cancel:(id)sender;
-(void)save:(id)sender;

@end


@implementation CBImageEditorController

@synthesize delegate = _delegate;

- (id) init {
	if (self = [super init]) {
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
		_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[_scrollView addSubview:_imageView];
		 
		[self.view addSubview:_scrollView];
		
		UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																				target:self
																				action:@selector(cancel:)];
		self.navigationItem.leftBarButtonItem = cancel;
		
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																					target:self
																					action:@selector(save:)];
		saveButton.style = UIBarButtonItemStyleDone;
		self.navigationItem.rightBarButtonItem = saveButton;
		/*
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
																								target:self 
																								action:@selector(cancel:)] autorelease];
		*/
		/*[self setToolbarItems:[NSArray arrayWithObjects:
							   [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil] autorelease],
							   [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
																			  target:self 
																			  action:@selector(chooseImage:)] autorelease],
							   nil] animated:YES];*/
	}
	return self;
}

- (void)dealloc {
	_scrollView = nil;
	_imageView = nil;
	_toolBar = nil;
	
}

- (void) setImage:(UIImage*)image {
	if (image) {
		_imageView.image = image;
		_imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
		_scrollView.contentSize = image.size;
	}
}

#pragma mark CBEditorController

- (void) openEditorForCell:(CBCell*)cell 
			  inController:(CBConfigurableTableViewController*)controller {
	_cell = cell;
	_controller = controller;
	
	UIImage *image = [controller valueForCell:cell];
	[self setImage:image];
	
	[controller.navigationController pushViewController:self animated:YES];
	[self performSelector:@selector(chooseImage:) withObject:self afterDelay:0.5];
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

#pragma mark UIActionSheetDelegate

- (void) pickImage:(UIImagePickerControllerSourceType)sourceType {
	// Let the user choose a new photo.
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self;
//	imagePicker.allowsEditing = YES;
	imagePicker.wantsFullScreenLayout = YES;
	[self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			[self pickImage:UIImagePickerControllerSourceTypePhotoLibrary];
			break;
		case 1:
			if ([self canTakePicture]) {
				[self pickImage:UIImagePickerControllerSourceTypeCamera];
			} else {
				[self cancel:actionSheet];
			}
			break;
		case 2:
			[self cancel:actionSheet];
			break;
		default:
			break;
	}
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker 
		didFinishPickingImage:(UIImage *)selectedImage 
				  editingInfo:(NSDictionary *)editingInfo {
    
    // Set the image for the photo object.
    [self setImage:selectedImage];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // The user canceled -- simply dismiss the image picker.
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Actions

- (BOOL) canTakePicture {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void) chooseImage:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:CBCTVLocalizedString(@"Choose Image Source")
															 delegate:self 
													cancelButtonTitle:CBCTVLocalizedString(@"Cancel")
											   destructiveButtonTitle:nil
													otherButtonTitles:
								  CBCTVLocalizedString(@"Choose Image"),
								  [self canTakePicture] ? CBCTVLocalizedString(@"Take Picture") : nil,
								  nil];
	[actionSheet showInView:self.view];
}

-(void)cancel:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender {
	[_controller setValue:_imageView.image forCell:_cell];
	
	if (_delegate && [_delegate respondsToSelector:@selector(editor:didChangeValue:)]) {
		[_delegate editor:self didChangeValue:_imageView.image];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
