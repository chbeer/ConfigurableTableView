//
//  CBEditorStepper.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.09.12.
//
//

#import "CBEditorStepper.h"

@implementation CBEditorStepper
{
    CBCell *_cell;
}

@synthesize minValue    = _minValue;
@synthesize maxValue    = _maxValue;
@synthesize stepValue   = _stepValue;


+ (id) editorWithMinValue:(float)min maxValue:(float)max stepValue:(float)step
{
	CBEditorStepper *editor = [[[self class] alloc] init];
    editor.minValue = min;
    editor.maxValue = max;
    editor.stepValue = step;
	return editor;
}

- (id) applyMinValue:(float)minValue {
    self.minValue = minValue;
    return self;
}
- (id) applyMaxValue:(float)maxValue {
    self.maxValue = maxValue;
    return self;
}
- (id) applyStepValue:(float)step {
    self.stepValue = step;
    return self;
}
- (id) applyMinValue:(float)minValue maxValue:(float)maxValue stepValue:(float)stepValue {
    self.minValue = minValue;
    self.maxValue = maxValue;
    self.stepValue = stepValue;
    return self;
}

#pragma mark - CBEditor

- (void)cell:(CBCell *)cell didSetupTableViewCell:(UITableViewCell *)tableViewCell withObject:(id)object inTableView:(UITableView *)tableView
{
    _cell = cell;

    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    [stepper sizeToFit];
    
    stepper.minimumValue = _minValue;
    stepper.maximumValue = _maxValue;
    stepper.stepValue = _stepValue;
    
    stepper.value = [[cell.controller valueForCell:cell] floatValue];
    
    [stepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];

    CGRect containerFrame = stepper.bounds;
    containerFrame.size.width += 5;
    UIView *container = [[UIView alloc] initWithFrame:containerFrame];
    
    stepper.frame = ({
        CGRect frame = stepper.frame;
        frame.origin.x += 5;
        frame;
    });
    [container addSubview:stepper];
    
    tableViewCell.accessoryView = container;

    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGSize) editorAccessorySize;
{
    return CGSizeMake(94 + 5, 27);
}

#pragma mark -

- (void) stepperChanged:(UIStepper*)sender {
    [_cell.controller setValue:[NSNumber numberWithDouble:sender.value]
                       forCell:_cell
                    withReload:YES];
}

@end
