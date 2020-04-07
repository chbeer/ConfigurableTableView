//
//  CBSectionOptions.m
//  libConfigurableTableView
//
//  Created by Christian Beer on 27.03.20.
//

#import "CBSectionOptions.h"

#import "CBCellStaticString.h"
#import "CBPickerOption.h"
#import "CBEditorTargetAction.h"
#import "CBConfigurableTableViewController.h"

@implementation CBSectionOptions {
    NSArray<CBPickerOption*> *_options;
    NSString *_valueKeyPath;
    id _defaultValue;
}


+ (instancetype) sectionWithTitle:(NSString*)title valuePath:(NSString*)valuePath options:(NSArray*)options
{

    NSMutableArray *cells = [NSMutableArray array];
    for (CBPickerOption *option in options) {
        [cells addObject:[CBCellStaticString cellWithTitle:option.label
                                                     value:option.value]];
    }

    CBSectionOptions *section = [[CBSectionOptions alloc] initWithTitle:title andCells:cells];
    
    for (CBCell *cell in cells) {
        [cell applyEditor:[CBEditorTargetAction editorWithTarget:section action:@selector(selectOption:)]];
    }
    
    section->_valueKeyPath = valuePath;
    section->_options = options;
    
    return section;
}

- (instancetype) applyDefaultValue:(id) defaultValue;
{
    _defaultValue = defaultValue;
    return self;
}

- (UITableViewCell*) tableView:(UITableView*)tableView
             cellForRowAtIndex:(NSInteger)index
                    controller:(UIViewController*)ctrl
                        object:(id)object
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndex:index
                                  controller:ctrl object:object];
    
    if (object && _valueKeyPath) {
        id val = [object valueForKeyPath:_valueKeyPath];
        if (!val) val = _defaultValue;
        if ([[_options objectAtIndex:index].value isEqual:val]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (IBAction) selectOption:(id)sender {
    NSInteger index = [self.cells indexOfObject:sender];
    if (index == NSNotFound) { return; }
    
    CBPickerOption *option = [_options objectAtIndex:index];
    [self.controller.data setValue:option.value forKeyPath:_valueKeyPath];
}

@end
