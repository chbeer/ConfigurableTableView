//
//  CBTableView.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CBTable;
@class CBSection;
@class CBCell;

@protocol CBSectionDelegate;

@protocol CBTableDelegate <NSObject>

- (void) table:(CBTable*)table sectionAdded:(CBSection*)section;
- (void) table:(CBTable*)table sectionsAdded:(NSArray<CBSection*>*)sections;
- (void) table:(CBTable*)table sectionRemovedAtIndex:(NSUInteger)index;

- (void) table:(CBTable*)table section:(CBSection*)section cellAddedAtIndexPath:(NSIndexPath*)indexPath;
- (void) table:(CBTable*)table section:(CBSection*)section cellsAddedAtIndexPaths:(NSArray<NSIndexPath*>*)indexPaths;;
- (void) table:(CBTable*)table section:(CBSection*)section cellRemovedAtIndexPath:(NSIndexPath*)indexPath;
- (void) table:(CBTable*)table section:(CBSection*)section cellsRemovedAtIndexPaths:(NSArray<NSIndexPath*>*)indexPaths;

@end


@interface CBTable : NSObject {
	NSMutableArray *_sections;
	
	id<CBTableDelegate> __weak _delegate;
}

@property (nonatomic, weak) id<CBTableDelegate> delegate;

@property (weak, readonly) NSArray *sections;

@property (nonatomic, assign, getter=isEnabled, setter=setEnabled:) BOOL enabled;

- (instancetype _Nonnull) init;
- (instancetype _Nonnull) initWithSections:(NSArray*)sections;

+ (instancetype) table;
+ (instancetype) tableWithSectionArray:(NSArray*)sections;
+ (instancetype) tableWithSections:(CBSection*)section, ...NS_REQUIRES_NIL_TERMINATION;

- (NSUInteger) sectionCount;
- (CBSection* _Nullable) sectionAtIndex:(NSUInteger)index;
- (NSUInteger) indexOfSection:(CBSection* _Nonnull)section;
- (NSUInteger) indexOfSectionWithTag:(NSString* _Nonnull)tag;
- (CBSection* _Nonnull) addSection:(CBSection* _Nonnull)section;
- (CBSection* _Nonnull) insertSection:(CBSection* _Nonnull)section atIndex:(NSUInteger)index;
- (void) removeSection:(CBSection* _Nonnull)section;
- (void) addSections:(CBSection* _Nonnull)section, ...NS_REQUIRES_NIL_TERMINATION;
- (void) addSectionsArray:(NSArray<CBSection*>* _Nonnull)sections;

- (CBSection* _Nullable) sectionWithTag:(NSString* _Nonnull)tag;
- (CBCell* _Nullable) cellWithTag:(NSString* _Nonnull)tag;
- (CBCell* _Nullable) cellWithValueKeyPath:(NSString* _Nonnull)valuePath;

- (NSIndexPath* _Nullable) indexPathOfCell:(CBCell* _Nonnull)cell;
- (NSIndexPath* _Nullable) indexPathOfCellWithTag:(NSString* _Nonnull)cellTag;
- (CBCell* _Nullable) cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (NSIndexPath* _Nullable) visibleIndexPathOfCell:(CBCell*)cell;
- (CBCell* _Nullable) visibleCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) setCell:(CBCell* _Nonnull)cell hidden:(BOOL)hidden;
- (void) setCellAtIndexPath:(NSIndexPath* _Nonnull)cell hidden:(BOOL)hidden;
- (void) setCellWithTag:(NSString* _Nonnull)tag hidden:(BOOL)hidden;

@end


@interface CBTable (Private)
	
- (void) addSectionsVargs:(va_list)args;

@end
