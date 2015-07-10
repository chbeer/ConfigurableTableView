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

@property (nonatomic, readwrite, strong) NSArray *options;

@property (nonatomic, weak) CBCell                            *originCell;
@property (nonatomic, weak) CBConfigurableTableViewController *originController;

@property (nonatomic, strong) CBConfigurableTableViewController *controller;

@end

@interface CBCellActionOption : CBCellAction

@property (nonatomic, strong) CBPickerOption *option;

+ (instancetype)cellWithTitle:(NSString *)title option:(CBPickerOption*)option target:(id)target action:(SEL)selector;

@end


@implementation CBEditorOptionsSubtable

- (id) initWithOptions:(NSArray*)options
{
    self = [super init];
    if (!self) return nil;
    
	_options = [options mutableCopy];

	return self;
}

+ (id) editorWithOptions:(NSArray*)options
{
	id editor = [(CBEditorOptionsSubtable*)[[self class] alloc] initWithOptions:options];
	return editor;
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
- (id) applyShouldReturnAfterSelection:(BOOL)shouldReturn;
{
    self.shouldReturnAfterSelection = shouldReturn;
    return self;
}

#pragma mark -

- (void) openEditorForCell:(CBCell*)cell
			  inController:(CBConfigurableTableViewController*)controller
{
    self.originCell = cell;
    self.originController = controller;
    
    CBTable *model = [CBTable table];
    CBSection *section = nil;
    BOOL firstSection = YES;
    
    id currentValue = [controller valueForCell:cell];
    
    for (id option in self.options) {
        NSString *label = option;
        UIImage *icon = nil;
        NSString *footerTitle = nil;
        BOOL enabled = YES;
        id value = option;
        if ([option isKindOfClass:[CBPickerOption class]]) {
            CBPickerOption *po = option;
            
            label = po.label;
            icon = po.icon;
            value = po.value;
            footerTitle = po.footerText;
            enabled = po.enabled;
        }
        
        if (!section) {
            section = [model addSection:[CBSection sectionWithTitle:firstSection ? self.sectionTitle : nil]];
        }
        
        if (footerTitle && !firstSection) {
            section = [model addSection:[CBSection sectionWithTitle:nil]];
        }
        
        id cell = [section addCell:[CBCellActionOption cellWithTitle:label option:option
                                                              target:self action:@selector(selectOption:)]];
        [cell setTextAlignment:UITextAlignmentLeft];
        [cell setEnabled:enabled];
        
        if (icon) {
            [cell applyIcon:icon];
        }
        
        if ([currentValue isEqual:value]) {
            [cell applyTableViewCellAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
        if (footerTitle) {
            section.footerTitle = footerTitle;
        }
        
        firstSection = NO;
    }
    
    CBConfigurableTableViewController *tableView = [[CBConfigurableTableViewController alloc] initWithTableModel:model
                                                                                                         andData:controller.data];
    self.controller = tableView;
    tableView.title = self.title;
    tableView.contentSizeForViewInPopover = controller.contentSizeForViewInPopover;
    [controller.navigationController pushViewController:tableView
                                               animated:YES];
}

- (BOOL) isInline {
	return NO;
}

#pragma mark - Actions

- (IBAction)selectOption:(id)sender
{
    CBCellActionOption *actionCell = sender;
    NSIndexPath *indexPath = [self.controller.model indexPathOfCell:actionCell];
    
    for (UITableViewCell *cell in [self.controller.tableView visibleCells]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell = [self.controller.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    id value = actionCell.option.value;

    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        id val = value;
        if ([val isKindOfClass:[CBPickerOption class]]) {
            val = ((CBPickerOption*)val).value;
        }
        
        [self.originController setValue:val forCell:self.originCell];
        if (self.shouldReturnAfterSelection) {
            [self.controller.navigationController popViewControllerAnimated:YES];
        }
    });
}

@end

@implementation CBCellActionOption

+ (instancetype)cellWithTitle:(NSString *)title option:(CBPickerOption*)option target:(id)target action:(SEL)action
{
    CBCellActionOption *cell = [[[self class] alloc] initWithTitle:title];
    
    cell.target = target;
    cell.action = action;
    
    cell.enabled = YES;
    cell.option = option;
    
    return cell;
}

@end