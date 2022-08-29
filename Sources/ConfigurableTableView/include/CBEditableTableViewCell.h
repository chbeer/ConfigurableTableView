#import <UIKit/UIKit.h>

@protocol CBEditableTableViewCellDelegate;

@interface CBEditableTableViewCell : UITableViewCell {
    id <CBEditableTableViewCellDelegate> __weak _delegate;
    BOOL _inlineEditing;
}

- (id)initWithReuseIdentifier:(NSString *)identifier;

// Exposes the delegate property to other objects.
@property (nonatomic, weak) id <CBEditableTableViewCellDelegate> delegate;
@property (nonatomic, assign, getter=isInlineEditing) BOOL inlineEditing;

// Informs the cell to stop editing, resulting in keyboard/pickers/etc. being ordered out 
// and first responder status resigned.
- (void)stopEditing;

@end

// Protocol to be adopted by an object wishing to customize cell behavior with respect to editing.
@protocol CBEditableTableViewCellDelegate <NSObject>

@optional

// Invoked before editing begins. The delegate may return NO to prevent editing.
- (BOOL)cellShouldBeginEditing:(CBEditableTableViewCell *)cell;
// Invoked after editing ends.
- (void)cellDidEndEditing:(CBEditableTableViewCell *)cell;

- (void)cell:(CBEditableTableViewCell*)cell didChangeValue:(id)value;

@end