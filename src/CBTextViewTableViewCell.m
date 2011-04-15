//
//  CBTextViewTableViewCell.m
//
//  Created by Christian Beer on 20.07.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBTextViewTableViewCell.h"

#import "CBCTVGlobal.h"

// table view cell content offsets
#define kCellLeftOffset			4.0
#define kCellTopOffset			8.0


@implementation CBTextViewTableViewCell

@synthesize delegate = _delegate;

@synthesize textView = _textView;

@synthesize keyboardType = _keyboardType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id)initWithReuseIdentifier:(NSString *)identifier 
                     andLabel:(NSString*)label {
	if (self = [super initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:identifier]) {
        // turn off selection use
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_textView = [[UITextView alloc] initWithFrame:self.contentView.bounds];
		_textView.font = [UIFont boldSystemFontOfSize:18];
		_textView.keyboardAppearance = _keyboardType;
        _textView.autocorrectionType = _autocorrectionType;
        _textView.autocapitalizationType = _autocapitalizationType;
		_textView.delegate = self;
        _textView.backgroundColor = self.contentView.backgroundColor;
        _textView.scrollEnabled = NO;
        _textView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        _textView.scrollsToTop = NO;
        _textView.userInteractionEnabled = NO;
		[self.contentView addSubview:_textView];
        
	}
	return self;
}

- (id)initWithReuseIdentifier:(NSString *)identifier {
	return [self initWithReuseIdentifier:identifier andLabel:nil];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing 
             animated:animated];
    
    _textView.userInteractionEnabled = editing;
    
    if (!CBIsIOSVersionGreaterEqual(4, 0)) {
        _textView.scrollEnabled = editing;
    }
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	_textView.frame  = self.contentView.bounds;
    
    if (self.textLabel.superview) {
        [self.textLabel removeFromSuperview];
    }
}

- (void)dealloc {
	_textView.delegate = nil;
    [_textView release];
    [super dealloc];
}

- (void)stopEditing {
    if (_object && _keyPath) {
        [_object setValue:_textView.text
               forKeyPath:_keyPath];
    }
    
    [_textView resignFirstResponder];
}

#pragma mark -

- (void) doneEditing:(id)sender {
    [_textView resignFirstResponder];
}
- (void) addDoneToolbarInputAccessoryView {
    // don't add for ipad because there is a dismiss button
    if (!CBCTVIsIPad() && [_textView respondsToSelector:@selector(setInputAccessoryView:)]) {
        UIToolbar *inputToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 
                                                                              300, 
                                                                              33.0)];
        inputToolbar.barStyle = UIBarStyleBlack;
        inputToolbar.translucent = YES;
        
        [inputToolbar setItems:[NSArray arrayWithObjects:
                                [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                               target:nil 
                                                                               action:0] autorelease],
                                [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(doneEditing:)] autorelease],
                                nil]];
        
        _textView.inputAccessoryView = inputToolbar;
        [inputToolbar release];
    }
}

#pragma mark <UITextViewDelegate> Methods

- (void) textViewDidBeginEditing:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewTableViewCellDidBeginEditing:)]) {
        [_delegate textViewTableViewCellDidBeginEditing:self];
    }
}

- (void) textViewDidChange:(UITextView *)textView {
    if (_object && _keyPath) {
        [_object setValue:textView.text
               forKeyPath:_keyPath];
    }
    
    if ([_delegate respondsToSelector:@selector(textViewTableViewCell:didChangeTextTo:)]) {
        [_delegate textViewTableViewCell:self 
                         didChangeTextTo:textView.text];
    }
}

- (void)setValue:(id)value {
	_textView.text = [NSString stringWithFormat:@"%@", value];
}

@end
