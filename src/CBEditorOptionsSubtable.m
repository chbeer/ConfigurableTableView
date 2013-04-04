//
//  CBEditorOptionsSubtable.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 02.04.13.
//
//

#import "CBEditorOptionsSubtable.h"

#import <objc/runtime.h>
#import "CBConfigurableTableViewController.h"


@interface CBEditorOptionsSubtable ()

@property (nonatomic, readwrite, retain) NSArray *options;

@property (nonatomic, assign) CBCell                            *originCell;
@property (nonatomic, assign) CBConfigurableTableViewController *originController;

@property (nonatomic, assign) CBConfigurableTableViewController *controller;

@end


@implementation CBEditorOptionsSubtable

- (id) initWithOptions:(NSArray*)options {
    self = [super init];
    if (!self) return nil;
    
	_options = [options mutableCopy];

	return self;
}

+ (id) editorWithOptions:(NSArray*)options {
	id editor = [(CBEditorOptionsSubtable*)[[self class] alloc] initWithOptions:options];
	return [editor autorelease];
}

- (id) applyTitle:(NSString*)title;
{
    self.title = title;
    return self;
}
- (id) applySectionTitle:(NSString*)sectionTitle;
{
    self.sectionTitle = sectionTitle;
    return self;
}

#pragma mark -

- (void) openEditorForCell:(CBCell*)cell
			  inController:(CBConfigurableTableViewController*)controller
{
    self.originCell = cell;
    self.originController = controller;
    
    CBTable *model = [CBTable table];
    CBSection *section = [model addSection:[CBSection sectionWithTitle:self.sectionTitle]];
    
    id currentValue = [controller valueForCell:cell];
    
    for (id option in self.options) {
        NSString *label = option;
        NSString *iconName = nil;
        id value = option;
        if ([option isKindOfClass:[CBPickerOption class]]) {
            label = [option label];
            iconName = [option iconName];
            value = [(CBPickerOption*)option value];
        }
        
        id cell = [section addCell:[CBCellAction cellWithTitle:label target:self action:@selector(selectOption:)]];
        [cell setTextAlignment:UITextAlignmentLeft];
        
        if (iconName) {
            [cell applyIconName:iconName];
        }
        
        if ([currentValue isEqual:value]) {
            [cell applyTableViewCellAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    
    CBConfigurableTableViewController *tableView = [[[CBConfigurableTableViewController alloc] initWithTableModel:model
                                                                                                          andData:controller.data] autorelease];
    self.controller = tableView;
    tableView.title = self.title;
    tableView.contentSizeForViewInPopover = controller.contentSizeForViewInPopover;
    [controller.navigationController pushViewController:tableView animated:YES];
    [tableView autorelease];
}

- (BOOL) isInline {
	return NO;
}

#pragma mark - Actions

- (IBAction)selectOption:(id)sender
{
    NSIndexPath *indexPath = [self.controller.model indexPathOfCell:sender];
    
    for (UITableViewCell *cell in [self.controller.tableView visibleCells]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell = [self.controller.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        id val = [self.options objectAtIndex:indexPath.row];
        if ([val isKindOfClass:[CBPickerOption class]]) {
            val = ((CBPickerOption*)val).value;
        }
        
        [self.originController setValue:val forCell:self.originCell];
        
        [self.controller.navigationController popViewControllerAnimated:YES];
    });
}

@end
