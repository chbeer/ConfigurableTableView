
//
//  CBMultilineTableViewCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBMultilineTableViewCell.h"

#import "CBCTVGlobal.h"
#import "CBEditor.h"

#define FONT_SIZE 18
#define MAX_HEIGHT 10000

@implementation CBMultilineTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)ident {
    if (self = [super initWithStyle:style reuseIdentifier:ident]) {

		self.textLabel.text = @"";
		self.textLabel.numberOfLines = 0;
		self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
		
    }
    return self;
}



+ (CGFloat) calculateHeightForCell:(CBCell*)cell
                       inTableView:(UITableView*)tableView
                          withText:(NSString*)text
                           andFont:(UIFont*)font
{
	CGFloat width = CBCTVCellLabelWidth(tableView);
    switch (cell.accessoryType) {
        case UITableViewCellAccessoryCheckmark:
        case UITableViewCellAccessoryDisclosureIndicator:
        case UITableViewCellAccessoryDetailDisclosureButton:
            width -= 25;
            break;
            
        default:
            break;
    }
    
    if (cell.editor && [cell.editor respondsToSelector:@selector(editorAccessorySize)]) {
        CBEditor *editor = cell.editor;
        width -= [editor editorAccessorySize].width;
    }
	
	CGSize constraint = CGSizeMake(width, MAX_HEIGHT);
	
	UIFont *fnt = font ? font : [UIFont boldSystemFontOfSize:FONT_SIZE];
	
    CGFloat height = 0.0;
    @synchronized(text){
        CGSize size = [text sizeWithFont:fnt
                       constrainedToSize:constraint 
                           lineBreakMode:NSLineBreakByWordWrapping];
        
        height = MAX(MIN(size.height + 20, MAX_HEIGHT), 44.0);
    }	
	return ceilf(height);
}


@end
