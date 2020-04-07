//
//  CBCellStaticString.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 24.10.14.
//
//

#import "CBCellString.h"


@interface CBCellStaticString : CBCellString

@property (nonatomic, copy) NSString *value;

+ (id) cellWithTitle:(NSString*)title value:(NSString*)value;

@end
