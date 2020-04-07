//
//  CBSectionOptions.h
//  libConfigurableTableView
//
//  Created by Christian Beer on 27.03.20.
//

#import "CBSection.h"

@interface CBSectionOptions : CBSection

+ (instancetype) sectionWithTitle:(NSString*)title valuePath:(NSString*)valuePath options:(NSArray*)options;

- (instancetype) applyDefaultValue:(id)defaultValue;

@end

