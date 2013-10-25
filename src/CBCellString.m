//
//  CBCellString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCellString.h"

#import "CBCTVGlobal.h"

#import "CBConfigurableTableView/CBEditor.h"
#import "CBConfigurableTableView/CBMultilineTableViewCell.h"

@implementation CBCellString

@synthesize multiline = _multiline;


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

- (id)applyMultiline {
    self.multiline = YES;
    self.style = UITableViewCellStyleDefault;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	NSString *reuseId = _multiline ? @"CBString_Multiline" : @"CBCellString";
    if (self.font) {
        reuseId = [reuseId stringByAppendingFormat:@"%x", [[self.font description] hash]];
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

- (CGFloat) calculateHeightForCell:(CBCell*)cell inTableView:(UITableView*)tableView withText:(NSString*)text
{
	CGFloat height = 44;

	if (text) {
		height = [CBMultilineTableViewCell calculateHeightForCell:cell
                                                      inTableView:tableView
                                                         withText:text
                                                          andFont:self.font];// + 10;
        if (height < 0) {
            height = 0;
        } else if (height > 2009) {
            height = 2009;
        }
	}
	
	return height;
}

- (void) setValue:(id)value 
		   ofCell:(UITableViewCell*)cell
	  inTableView:(UITableView*)tableView {
    
    NSString *translatedValue = nil;
    if (self.valueTranslation) {
        translatedValue = self.valueTranslation(value);
    } else {
        translatedValue = value ? [NSString stringWithFormat:@"%@", value] : @"";
    }
    
    if(self.style == UITableViewCellStyleDefault && !self.title) {
        cell.textLabel.text = translatedValue;
    } else {
        cell.detailTextLabel.text = translatedValue;
        cell.detailTextLabel.enabled = self.enabled;
    }
    
    if (_multiline) {     
		[cell.textLabel setFrame:CGRectMake(10, 10,
											CBCTVCellLabelWidth(tableView),
											[self calculateHeightForCell:self
                                                             inTableView:tableView
                                                                withText:cell.textLabel.text] - 20)];
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
		height = [self calculateHeightForCell:self inTableView:tableView withText:text];
	} else if (self.font) {
        height = [self.font pointSize] + 10;
    }

	return height;
}

@end
