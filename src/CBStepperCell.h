//
//  CBStepperCell.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "CBConfigTableViewCell.h"

@interface CBStepperCell : CBConfigTableViewCell

@property (nonatomic, retain)               UIStepper *stepper;;

@property (nonatomic, assign)               float minValue;
@property (nonatomic, assign)               float maxValue;
@property (nonatomic, assign)               float stepValue;
@property (nonatomic, assign)               double value;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
