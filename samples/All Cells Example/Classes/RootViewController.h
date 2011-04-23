//
//  RootViewController.h
//  ConfigurableTableViewExample
//
//  Created by Christian Beer on 04.12.09.
//  Copyright Christian Beer 2009. All rights reserved.
//

#import "CBConfigurableTableView/CBConfigurableTableView.h"

@interface RootViewController : CBConfigurableTableViewController {
	
}

@end


/////////////////////////////////////////////////////////////
///// Helper Classes ////////////////////////////////////////
/////////////////////////////////////////////////////////////

@interface DummyDataObject : NSObject {
	NSString *name;
	NSString *firstName;
	NSString *password;
	NSString *description;
	
	int age;
	float decimal;
	float euro;
	float percent;
	float slider;
	float repeat;
	
	BOOL male;
	
	UIImage *image;
	NSData *sound;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) int age;
@property (nonatomic, assign) float decimal;
@property (nonatomic, assign) float euro;
@property (nonatomic, assign) float slider;
@property (nonatomic, assign) float percent;
@property (nonatomic, assign) float repeat;

@property (nonatomic, assign) BOOL male;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSData *sound;

@end