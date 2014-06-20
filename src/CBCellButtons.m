//
//  CBCellButtons.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 11.09.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellButtons.h"

@interface CBCellButtonsTableViewCell : UITableViewCell {
    
}

@end


@implementation CBCellButtons

- (id) initWithTitle:(NSString*)title {
	if (self = [super init]) {
		_buttons = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) dealloc {
    _buttons = nil;
    
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return [_buttons description];
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	CBCellButtonsTableViewCell *cell =  [[CBCellButtonsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:[self reuseIdentifier]];
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectZero];
    bg.backgroundColor = [UIColor clearColor];
    bg.opaque = NO;
    cell.backgroundView = bg;
    
    CGRect r = cell.contentView.bounds;
    CGFloat bw = (r.size.width - (10 * (_buttons.count - 1))) / _buttons.count;
    CGFloat bh = r.size.height - 10;
    
    CGFloat x = 0;
    for (UIButton *btn in _buttons) {
        btn.frame = CGRectMake(x, 5, bw, bh);
        x += bw + 10;
        
        [cell.contentView addSubview:btn];
    }
    
	return cell;
}

- (BOOL) hasEditor {
	return NO;
}

- (UIButton*) addButtonWithTitle:(NSString*)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title 
         forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] 
              forState:UIControlStateDisabled];
    [btn addTarget:target
            action:action
  forControlEvents:UIControlEventTouchUpInside];
    [_buttons addObject:btn];
    
    return btn;
}


@end



@implementation CBCellButtonsTableViewCell

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGRect r = self.contentView.bounds;
    CGFloat bw = (r.size.width - (10 * (self.contentView.subviews.count - 1))) / self.contentView.subviews.count;
    CGFloat bh = r.size.height - 10;
    
    CGFloat x = 0;
    for (UIButton *btn in self.contentView.subviews) {
        btn.frame = CGRectMake(x, 5, bw, bh);
        x += bw + 10;
    }
}

@end