//
//  CBCellSubtable.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellSubtable.h"

#import "CBConfigurableTableViewController.h"
#import "CBTable.h"

@implementation CBCellSubtable

@synthesize model = _model;

+ (id) cellWithTitle:(NSString*)title sectionArray:(NSArray*)sections {
	CBTable *model = [CBTable tableWithSectionArray:sections];
	
	CBCellSubtable *cell = [[[self class] alloc] initWithTitle:title 
                                                      andModel:model];
	return cell;
}
+ (id) cellWithTitle:(NSString*)title sections:(CBSection*)section, ... {
	CBTable *model = [[CBTable alloc] init];
	
	[model addSection:section];
	
	va_list args;
    va_start(args, section);
	[model addSectionsVargs:args];
	
	CBCellSubtable *cell = [[[self class] alloc] initWithTitle:title 
                                                      andModel:model];
	
	
	return cell;
}

- (id) initWithTitle:(NSString*)title andModel:(CBTable*)model {
	if (self = [super initWithTitle:title]) {
		_model = model;
	}
	return self;
}


#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellSubtable";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
								  reuseIdentifier:[self reuseIdentifier]];
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
    [super setupCell:cell withObject:object inTableView:tableView];
    
	cell.textLabel.text = self.title;

	cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (BOOL) hasEditor {
	return YES;
}
- (void) openEditorInController:(CBConfigurableTableViewController*)controller {
	CBConfigurableTableViewController *tableView = [[CBConfigurableTableViewController alloc] initWithTableModel:_model 
																										andData:controller.data];
    tableView.preferredContentSize = controller.preferredContentSize;
	[controller.navigationController pushViewController:tableView animated:YES];
}
- (void) setEditor:(CBEditor*)editor {
	// intentionally does nothing
	NSLog(@"setEditor of class CBCellSubtable should not be called!");
}

#pragma mark Section access

- (NSUInteger) sectionCount {
	return [_model sectionCount];
}

- (CBSection*) sectionAtIndex:(NSUInteger)index {
	return [_model sectionAtIndex:index];
}

- (CBSection*) addSection:(CBSection*)section {
	return [_model addSection:section];
}
- (void) addSections:(CBSection*)section, ... {
	
	[_model addSection:section];
	
	va_list args;
    va_start(args, section);
	[_model addSectionsVargs:args];
}

@end
