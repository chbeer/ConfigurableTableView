//
//  CBCellSubtable.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 07.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"

@class CBTable;
@class CBSection;

@interface CBCellSubtable : CBCell {
	CBTable *_model;
}

@property (readonly) CBTable *model;

+ (id) cellWithTitle:(NSString*)title sectionArray:(NSArray*)sections;
+ (id) cellWithTitle:(NSString*)title sections:(CBSection*)section, ...;

- (id) initWithTitle:(NSString*)title andModel:(CBTable*)model;

- (NSUInteger) sectionCount;
- (CBSection*) sectionAtIndex:(NSUInteger)index;
- (CBSection*) addSection:(CBSection*)section;
- (void) addSections:(CBSection*)section, ...;



@end
