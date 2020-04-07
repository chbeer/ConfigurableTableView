//
//  CBCellStaticString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.10.14.
//
//

#import "CBCellStaticString.h"

@implementation CBCellStaticString

+ (instancetype) cellWithTitle:(NSString*)title value:(NSString*)value
{
    CBCellStaticString *cell = [super cellWithTitle:title valuePath:nil];
    cell.value = value;
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell withObject:(NSObject *)object inTableView:(UITableView *)tableView
{
    [super setupCell:cell withObject:object inTableView:tableView];
    cell.detailTextLabel.text = self.value;
}

@end
