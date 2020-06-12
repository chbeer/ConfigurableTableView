//
//  CBCellStaticString.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.10.14.
//
//

#import "CBCellStaticString.h"

@implementation CBCellStaticString

- (instancetype) initWithTitle:(NSString *)title value:(NSString*)value
{
    self = [super initWithTitle:title];
    if (!self) return nil;
    
    self.value = value;
    self.style = UITableViewCellStyleSubtitle;
    
    return self;
}

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
    cell.detailTextLabel.numberOfLines = 0;
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object {
    return UITableViewAutomaticDimension;
}

@end
