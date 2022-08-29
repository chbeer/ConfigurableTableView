//
//  CBEditorStepper.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 12.09.12.
//
//

#import "CBConfigurableTableView.h"

@interface CBEditorStepper : CBEditor

@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float stepValue;


+ (id) editorWithMinValue:(float)min maxValue:(float)max stepValue:(float)step;

- (id) applyMinValue:(float)minValue;
- (id) applyMaxValue:(float)maxValue;
- (id) applyStepValue:(float)step;
- (id) applyMinValue:(float)minValue maxValue:(float)maxValue stepValue:(float)stepValue;

@end
