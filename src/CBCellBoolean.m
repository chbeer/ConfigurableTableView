//
//  CBCellBoolean.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellBoolean.h"


@implementation CBCellBoolean

@synthesize inverted = _inverted;

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellBoolean";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
								  reuseIdentifier:[self reuseIdentifier]];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return [cell autorelease];
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	if (value && [value isKindOfClass:[NSNumber class]]) {
		UISwitch *s = (UISwitch*)cell.accessoryView;
        
        BOOL boolValue = [(NSNumber*)value boolValue];
        if (_inverted) {
            boolValue = !boolValue;
        }
		[s setOn:boolValue animated:NO];
	}
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	_object = object;
	
	if (!_switch) {
		_switch = [[UISwitch alloc] init];
		[_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
	}
	cell.accessoryView = _switch;

	CGPoint o = cell.textLabel.frame.origin;
	CGSize s = cell.textLabel.frame.size;
	cell.textLabel.frame = CGRectMake(o.x, _switch.frame.origin.y, s.width - _switch.frame.size.width, _switch.frame.size.height);

    [super setupCell:cell withObject:object inTableView:tableView];
}

- (void) switchChanged:(id)sender {
	if (_object && _valueKeyPath) {
        BOOL value = _switch.on;
        if (_inverted) {
            value = !value;
        }
		[_object setValue:[NSNumber numberWithBool:value] 
               forKeyPath:_valueKeyPath];
	}
}

- (void) dealloc {
	[_switch release];
	
	[super dealloc];
}

#pragma mark -

- (CBCellBoolean*) applyInverted:(BOOL) inverted {
    _inverted = inverted;
    
    return self;
}

@end
