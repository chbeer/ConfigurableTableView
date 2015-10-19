//
//  CBCellBoolean.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellBoolean.h"

#import "CBCTVGlobal.h"
#import "NSString+CBCTV.h"

@interface CBCellBoolean ()

@property (nonatomic, readonly, strong) UISwitch *switchControl;

@end


@implementation CBCellBoolean

@synthesize inverted = _inverted;

@dynamic switchControl;


#pragma mark - Accessors

- (id) applyInverted:(BOOL) inverted {
    _inverted = inverted;
    
    return self;
}

- (void) setWorking:(BOOL)working
{
    self.switchControl.hidden = working;
    if (!working && _activityView) {
        [_activityView removeFromSuperview];
    } else {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView sizeToFit];
        _activityView.center = self.switchControl.center;
        [_activityView startAnimating];
        [self.switchControl.superview addSubview:_activityView];
    }
}

#pragma mark - CBCell protocol

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:[self reuseIdentifier]];
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
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

- (UISwitch*)switchControl
{
    if (_switch) return _switch;
    
    _switch = [[UISwitch alloc] init];
    [_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return _switch;
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	_object = object;
	
	CGPoint o = cell.textLabel.frame.origin;
	CGSize s = cell.textLabel.frame.size;
	cell.textLabel.frame = CGRectMake(o.x, o.y, s.width - self.switchControl.frame.size.width, s.height);
    cell.textLabel.numberOfLines = 0;
    
    self.switchControl.enabled = self.enabled;
    cell.accessoryView = self.switchControl;
    
    [super setupCell:cell withObject:object inTableView:tableView];
    
    cell.accessoryView = self.switchControl;
}

- (void) switchChanged:(id)sender {
	if (_object && self.valueKeyPath) {
        BOOL value = self.switchControl.on;
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

    CGSize constraints = CGSizeMake(CBCTVCellLabelWidth(tableView) - self.switchControl.bounds.size.width, 2009);
    height = [self.title cbctv_sizeWithFont:[UIFont systemFontOfSize:[UIFont labelFontSize]]
                          constrainedToSize:constraints lineBreakMode:NSLineBreakByWordWrapping].height + 20;
    
	return MAX(ceilf(height), 44);
}

@end
