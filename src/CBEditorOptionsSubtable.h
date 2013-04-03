//
//  CBEditorOptionsSubtable.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 02.04.13.
//
//

#import <CBConfigurableTableView/CBConfigurableTableView.h>

@interface CBEditorOptionsSubtable : CBEditor

@property (nonatomic, readonly, retain) NSArray *options;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sectionTitle;

- (id) initWithOptions:(NSArray*)options;

+ (id) editorWithOptions:(NSArray*)options;

- (id) applyTitle:(NSString*)title;
- (id) applySectionTitle:(NSString*)sectionTitle;

@end
