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

- (void) dealloc {
	[_switch release];
	
	[super dealloc];
}

#pragma mark - Accessors

- (id) applyInverted:(BOOL) inverted {
    _inverted = inverted;
    
    return self;
}

- (void) setWorking:(BOOL)working
{
    _switch.hidden = working;
    if (!working && _activityView) {
        [_activityView removeFromSuperview];
    } else {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView sizeToFit];
        _activityView.center = _switch.center;
        [_activityView startAnimating];
        [_switch.superview addSubview:_activityView];
        [_activityView release];
    }
}

#pragma mark - CBCell protocol

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
    
	CGPoint o = cell.textLabel.frame.origin;
	CGSize s = cell.textLabel.frame.size;
	cell.textLabel.frame = CGRectMake(o.x, o.y, s.width - _switch.frame.size.width, s.height);
    cell.textLabel.numberOfLines = 0;
    
    _switch.enabled = self.enabled;
    
    [super setupCell:cell withObject:object inTableView:tableView];
    
    cell.accessoryView = _switch;
}

- (void) switchChanged:(id)sender {
	if (_object && self.valueKeyPath) {
        BOOL value = _switch.on;
        if (_inverted) {
            value = !value;
        }
		[_object setValue:[NSNumber numberWithBool:value] 
               forKeyPath:self.valueKeyPath];
	}
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object
{
	CGFloat height = 44;

    CGSize constraints = CGSizeMake(CBCTVCellLabelWidth(tableView) - 79 - 10, 2009);
    height = [self.title sizeWithFont:[UIFont boldSystemFontOfSize:17]
                    constrainedToSize:constraints lineBreakMode:NSLineBreakByWordWrapping].height + 20;
    
	return height;
}

@end
