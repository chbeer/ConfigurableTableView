//
//  CBCellString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellString.h"

#import "CBConfigurableTableView/CBEditor.h"
#import "CBConfigurableTableView/CBMultilineTableViewCell.h"

@implementation CBCellString

@synthesize multiline = _multiline;
@synthesize font = _font;
@synthesize detailFont = _detailFont;


- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
		self.style = title ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault;
		self.multiline = NO;
	}
	return self;
}
- (id) initWithTitle:(NSString*)title 
        andValuePath:(NSString*)valueKeyPath {
	if (self = [self initWithTitle:title]) {
		self.valueKeyPath = valueKeyPath;
        
        if (title && !valueKeyPath) {
            self.style = UITableViewCellStyleDefault;
        }
	}
	return self;
}

- (void) dealloc {
    self.font = nil;
    self.detailFont = nil;
    
    [super dealloc];
}

+ (id) cellMultilineWithValuePath:(NSString*)path {
	CBCellString *cell = (CBCellString*)[self cellWithTitle:nil valuePath:path];
	cell.multiline = YES;
    cell.style = UITableViewCellStyleDefault;
	return cell;
}

- (id)applyFont:(UIFont*)font {
    self.font = font;
    return self;
}
- (id)applyDetailFont:(UIFont*)font {
    self.detailFont = font;
    return self;
}

- (id)applyMultiline {
    self.multiline = YES;
    self.style = UITableViewCellStyleDefault;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	NSString *reuseId = _multiline ? @"CBString_Multiline" : @"CBCellString";
    if (_font) {
        reuseId = [reuseId stringByAppendingFormat:@"%x", [[_font description] hash]];
    }
    return [reuseId stringByAppendingFormat:@"_%d", self.style];
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell = nil;
	
	if (_multiline) {
		cell = [[CBMultilineTableViewCell alloc] initWithStyle:self.style
											   reuseIdentifier:[self reuseIdentifier]];
	} else {
		cell = [[UITableViewCell alloc] initWithStyle:self.style
									  reuseIdentifier:[self reuseIdentifier]];
	}
	
	return [cell autorelease];
}

- (CGFloat) calculateHeightForCellInTableView:(UITableView*)tableView withText:(NSString*)text {
	CGFloat height = 44;

	if (text) {
		height = [CBMultilineTableViewCell calculateHeightInTableView:tableView 
															 withText:text
															  andFont:_font];// + 10;
	}
	
	return height;
}

- (void) setValue:(id)value 
		   ofCell:(UITableViewCell*)cell
	  inTableView:(UITableView*)tableView {
    if(self.style == UITableViewCellStyleDefault && !self.title) {
        cell.textLabel.text = value ? [NSString stringWithFormat:@"%@", value] : @"";
    } else {
        cell.detailTextLabel.text = value ? [NSString stringWithFormat:@"%@", value] : @"";
        cell.detailTextLabel.enabled = self.enabled;
    }
    
    if (_multiline) {     
		[cell.textLabel setFrame:CGRectMake(10, 10,
											CBCTVCellLabelWidth(tableView),
											[self calculateHeightForCellInTableView:tableView 
																		   withText:cell.textLabel.text] - 20)];
	} 
}

- (void) setupCell:(UITableViewCell *)cell withObject:(NSObject *)object inTableView:(UITableView *)tableView {
    [super setupCell:cell
          withObject:object 
         inTableView:tableView];
    
    if (_font) {
		cell.textLabel.font = _font;
	}
    if (_detailFont) {
		cell.detailTextLabel.font = _detailFont;
	}
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object {
	CGFloat height = 44;
	
	if (_multiline) {
        NSString *text = nil;
        if (self.valueKeyPath && object) {
            text = [object valueForKeyPath:self.valueKeyPath];
        } else {
            text = self.title;
        }
		height = [self calculateHeightForCellInTableView:tableView withText:text];
	} else if (_font) {
        height = [_font pointSize] + 10;
    }

	return height;
}

@end
