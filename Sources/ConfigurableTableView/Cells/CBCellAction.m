//
//  CBCellAction.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 27.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellAction.h"

#import "CBCTVGlobal.h"

@implementation CBCellAction

@synthesize target = _target;
@synthesize action = _action;

@synthesize enabled = _enabled;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)selector
{
	self = [super initWithTitle:title];
    if (!self) return nil;
    
    NSAssert(selector != NULL, @"action can not be nil");

    _target = target;
    _action = selector;
    _textAlignment = NSTextAlignmentCenter;
    _enabled = YES;

	return self;
}
- (instancetype)initWithTitle:(NSString *)title actionBlock:(CBCellActionBlock)block
{
    self = [super initWithTitle:title];
    if (!self) return nil;
    
    _actionBlock = [block copy];
    _textAlignment = NSTextAlignmentCenter;
    _enabled = YES;

    return self;
}

+ (instancetype)cellWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    CBCellAction *cell = [[[self class] alloc] initWithTitle:title target:target action:action];
    
    cell.enabled = YES;
	
	return cell;
}
+ (instancetype)cellWithTitle:(NSString *)title actionBlock:(CBCellActionBlock)block;
{
    CBCellAction *cell = [[[self class] alloc] initWithTitle:title];
	
	cell.actionBlock = block;
    cell.enabled = YES;
	
	return cell;
}

- (instancetype) applyTextAlignment:(NSTextAlignment)textAlignment
{
    self.textAlignment = textAlignment;
    return self;
}
- (instancetype) applyTableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType;
{
    self.cellAccessoryType = accessoryType;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellAction";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
													reuseIdentifier:[self reuseIdentifier]];

	return cell;
}
- (void)setupCell:(UITableViewCell *)cell withObject:(NSObject *)object inTableView:(UITableView *)tableView
{
    [super setupCell:cell withObject:object inTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = self.cellAccessoryType;
    
    cell.textLabel.textAlignment = self.textAlignment;
    if (!self.font) {
        if (CBCTVIsIOS7()) {
            cell.textLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
            cell.textLabel.textColor = [tableView tintColor];
        } else {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize];
        }
    }
    
    cell.textLabel.enabled = _enabled;
}

- (BOOL) hasEditor {
	return YES;
}
- (BOOL)isEditorInline
{
    return YES;
}

- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
    if (!self.enabled) return;
    
    if (self.actionBlock) {
        self.actionBlock();
    } else {
        [[UIApplication sharedApplication] sendAction:self.action to:self.target from:self forEvent:nil];
    }
}

@end
