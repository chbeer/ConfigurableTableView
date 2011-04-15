
//
//  CBMultilineTableViewCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBMultilineTableViewCell.h"

#define FONT_SIZE 18
#define MAX_HEIGHT 10000

@implementation CBMultilineTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)ident {
    if (self = [super initWithStyle:style reuseIdentifier:ident]) {

		self.textLabel.text = @"";
		self.textLabel.numberOfLines = 0;
		self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		
    }
    return self;
}


- (void)dealloc {	
    [super dealloc];
}

+ (CGFloat) calculateHeightInTableView:(UITableView*)tableView withText:(NSString*)text 
							   andFont:(UIFont*)font {
	CGFloat width = CBCTVCellLabelWidth(tableView);
	
	CGSize constraint = CGSizeMake(width, MAX_HEIGHT);
	
	UIFont *fnt = font ? font : [UIFont boldSystemFontOfSize:FONT_SIZE];
	
	CGSize size = [text sizeWithFont:fnt
				   constrainedToSize:constraint 
					   lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat height = MAX(MIN(size.height + 16, MAX_HEIGHT), 44.0);
	
	return height;
}

@end
