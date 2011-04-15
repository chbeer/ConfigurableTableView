//
//  RootViewController.m
//  ConfigurableTableViewExample
//
//  Created by Christian Beer on 04.12.09.
//  Copyright Christian Beer 2009. All rights reserved.
//

#import "RootViewController.h"

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


@implementation RootViewController

- (NSArray*) numberArrayFrom:(int)f to:(int)t {
	NSMutableArray *a = [NSMutableArray array];
	for (int i = f; i <= t; i++) {
		[a addObject:[NSNumber numberWithInt:i]];
	}
	return a;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	DummyDataObject *data = [[DummyDataObject alloc] init];
	data.firstName = @"Tom";
	data.name = @"Tester";
	data.password = @"abcdef";
	data.description = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
	data.age = 12;
	data.decimal = 12.23;
	data.euro = 16.95;
	data.male = YES;
	data.percent = 0.25;
	data.slider = 0.8;
	data.repeat = 0.5;
	
	CBCell *numWithEditor = [CBCellNumeric cellWithTitle:@"Age With Editor" valuePath:@"age"];
	numWithEditor.editor = [CBEditorPicker editorWithOptions:[self numberArrayFrom:1 to:99]];
	
	CBCellNumeric *decimalCell = [CBCellNumeric cellWithTitle:@"Decimal Number" valuePath:@"decimal"];
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setGeneratesDecimalNumbers:YES];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	decimalCell.numberFormatter = formatter;
	[formatter release];
	
	CBCellNumeric *currencyCell = [CBCellNumeric cellWithTitle:@"Currency" valuePath:@"euro"];
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	currencyCell.numberFormatter = currencyFormatter;
	[currencyFormatter release];
	
	CBCellSubtable *subTableCell = [CBCellSubtable cellWithTitle:@"Subtable Demo" 
												sections:
							[CBSection sectionWithTitle:@"Strings"
											   andCells:
								[CBCellString cellWithTitle:@"Name" valuePath:@"name"],
								[CBCellString cellWithTitle:@"First Name" valuePath:@"firstName"],
								nil],
							nil];
	
	CBTable *model = [CBTable tableWithSections:
						[CBSection sectionWithTitle:@"Strings"
										   andCells:
							[CBCellString cellWithTitle:@"Name" valuePath:@"name"],
							[CBCellString cellWithTitle:@"First Name" valuePath:@"firstName"],
							[CBCellPassword cellWithTitle:@"Password" valuePath:@"password" 
												   editor:[CBEditorPassword editor]],
							[CBCellString cellMultilineWithValuePath:@"description"],
							 nil],
						[CBSection sectionWithTitle:@"Numeric"
										   andCells:
							[CBCellNumeric cellWithTitle:@"Age" valuePath:@"age"],
							decimalCell,
							currencyCell,
							[CBCellNumericSlider cellWithTitle:@"Slider Demo" valuePath:@"slider"],
							[CBCellNumericSlider cellWithTitle:@"Percentage" valuePath:@"percent" minLabel:@"0 %" maxLabel:@"100 %"],
							[CBCellNumericSlider cellWithTitle:@"Repeat" valuePath:@"repeat" minLabel:@"rarely" maxLabel:@"often"],
							numWithEditor,
							nil],
						[CBSection sectionWithTitle:@"Boolean"
										   andCells:
							[CBCellBoolean cellWithTitle:@"Male" valuePath:@"male"],
							nil],
						[CBSection sectionWithTitle:@"Sub-Table"
										   andCells:
							subTableCell,
						   nil],
						[CBSection sectionWithTitle:@"Specials"
										   andCells:
							[CBCellImage cellWithTitle:@"Image" valuePath:@"image" editable:YES],
						 nil],
					  nil];

	self.model = model;
	self.data = data;
		
	[data release];
	
}

- (void)dealloc {
    [super dealloc];
}


@end

@implementation DummyDataObject 

@synthesize name, firstName, password, description, age, decimal, euro, percent, slider,repeat, male, image, sound;

// dealloc misssing ... it's only an example

@end