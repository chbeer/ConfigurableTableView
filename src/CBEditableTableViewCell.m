
#import "CBEditableTableViewCell.h"

@implementation CBEditableTableViewCell

// Instruct the compiler to create accessor methods for the property.
// It will use the internal variable with the same name for storage.
@synthesize delegate = _delegate;
@synthesize inlineEditing = _inlineEditing;

- (id)initWithReuseIdentifier:(NSString *)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]) {
	}
	return self;
}

// To be implemented by subclasses. 
- (void)stopEditing {
}

@end
