//
//  CBCellDate.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellDate.h"


@implementation CBCellDate

@synthesize dateFormatter = _dateFormatter;

- (id) initWithTitle:(NSString*)title {
	self = [super initWithTitle:title];
    if (!self) return nil;
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    return self;
}

+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath dateStyle:(NSDateFormatterStyle)dateStyle editor:(CBEditor*)editor {
    CBCellDate *cell = [[self alloc] initWithTitle:title andValuePath:valueKeyPath];
    cell.dateFormatter.dateStyle = dateStyle;
    cell.dateFormatter.timeStyle = NSDateFormatterNoStyle;
    cell.editor = editor;
    return cell;
}
+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath dateStyle:(NSDateFormatterStyle)dateStyle
{
    return [self cellWithTitle:title valuePath:valueKeyPath dateStyle:dateStyle editor:nil];
}
+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath timeStyle:(NSDateFormatterStyle)timeStyle editor:(CBEditor*)editor {
    CBCellDate *cell = [[self alloc] initWithTitle:title andValuePath:valueKeyPath];
    cell.dateFormatter.dateStyle = NSDateFormatterNoStyle;
    cell.dateFormatter.timeStyle = timeStyle;
    cell.editor = editor;
    return cell;
}
+ (id) cellWithTitle:(NSString *)title valuePath:(NSString *)valueKeyPath timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [self cellWithTitle:title valuePath:valueKeyPath timeStyle:timeStyle editor:nil];
}

- (id) applyDateStyle:(NSDateFormatterStyle)dateStyle
{
    self.dateFormatter.dateStyle = dateStyle;
    return self;
}
- (id) applyTimeStyle:(NSDateFormatterStyle)timeStyle
{
    self.dateFormatter.timeStyle = timeStyle;
    return self;
}
- (id) applyRelativeDateFormatting:(BOOL)relativeDateFormatting
{
    self.dateFormatter.doesRelativeDateFormatting = relativeDateFormatting;
    return self;
}
- (id) applyPlaceholderText:(NSString*)placeholder
{
    self.placeholderText = placeholder;
    return self;
}


#pragma mark CBCell protocol

- (UITableViewCellStyle) tableViewCellStyle {
    return UITableViewCellStyleValue1;
}

- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
	if (value && [value isKindOfClass:[NSDate class]]) {
		cell.detailTextLabel.text = [_dateFormatter stringFromDate:(NSDate*)value];
	} else {
		cell.detailTextLabel.text = self.placeholderText ?: @"";
	}
}

@end
