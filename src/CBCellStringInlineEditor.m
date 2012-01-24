//
//  CBCellStringTextView.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 08.03.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellStringInlineEditor.h"
#import <QuartzCore/QuartzCore.h>

#import "CBCTVGlobal.h"

#import "CBTextFieldTableViewCell.h"
#import "CBMultilineTableViewCell.h"

#import "CBConfigurableTableViewController.h"

/** !! Attention: not very clean implementation !! */

@interface CBCellStringInlineEditor () 

- (UITableViewCell*) createTextView;

@end



@implementation CBCellStringInlineEditor

@synthesize multiline = _multiline;
@synthesize font = _font;

@synthesize minHeight = _minHeight;
@synthesize maxHeight = _maxHeight;

@synthesize keyboardType = _keyboardType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
		_multiline = NO;
        
        _keyboardType = UIKeyboardTypeDefault;
		_autocorrectionType = UITextAutocorrectionTypeDefault;
        _autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _minHeight = -1;
        _maxHeight = -1;
        
        _currentTextViewHeight = 0.0;
	}
	return self;
}

+ (CBCellStringInlineEditor*) cellMultilineWithValuePath:(NSString*)path {
	CBCellStringInlineEditor *cell = (CBCellStringInlineEditor*)[[self class] cellWithTitle:nil 
                                                                                  valuePath:path];
	cell.multiline = YES;
    [cell createTextView];
    
	return cell;
}

- (id) applyFont:(UIFont*)font;
{
    self.font = font;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return _multiline ? @"CBStringTextView" : @"CBStringTextField" ;
}

- (UITableViewCell*) createTextView {
    CBTextViewTableViewCell *cell = [[CBTextViewTableViewCell alloc] initWithReuseIdentifier:[self reuseIdentifier] 
                                                                                   andLabel:self.title];
    _textViewCell = cell;
    return cell;
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell = nil;
	
	if (_multiline) {
		cell = _textViewCell;
	} else {
		cell = [[[CBTextFieldTableViewCell alloc] initWithReuseIdentifier:[self reuseIdentifier] 
                                                                 andLabel:self.title] autorelease];
	}
    
	return cell;
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object 
	   inTableView:(UITableView*)tableView {
	_object = object;
    
    CBTextFieldTableViewCell *tfc = (CBTextFieldTableViewCell*)cell;
    tfc.keyboardType = _keyboardType;
    tfc.autocorrectionType = _autocorrectionType;
    tfc.autocapitalizationType = _autocapitalizationType;
    
    if (_multiline) {
        CBTextViewTableViewCell *tvc = (CBTextViewTableViewCell*)tfc;
        tvc.delegate = self;
        
        if (_font) {
            tvc.textView.font = _font;
        }
    } else {
        if (_font) {
            tfc.textField.font = _font;
        }
    }
    
	[super setupCell:cell withObject:object 
		 inTableView:tableView];
}
- (void) setValue:(id)value 
		   ofCell:(UITableViewCell*)cell
	  inTableView:(UITableView*)tableView {
    
    if (_multiline) {
        _textViewCell = (CBTextViewTableViewCell*)cell;
    }
    
	if (_multiline) {
		CBTextViewTableViewCell *cellTV = (CBTextViewTableViewCell*)cell;
		cellTV.textView.text = value;
	} else {
		CBTextFieldTableViewCell *cellTV = (CBTextFieldTableViewCell*)cell;
		cellTV.textField.text = value;		
	}
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView 
						  withObject:(NSObject*)object {
	CGFloat height = 44;
	
	if (self.valueKeyPath && object && self.multiline && _textViewCell) {
        
        if (tableView.editing && !CBIsIOSVersionGreaterEqual(4, 0)) {
            
            height = 150;
            
        } else {
        
            NSString *text = [object valueForKeyPath:self.valueKeyPath];
            if (!_textViewCell.textView.text || ![_textViewCell.textView.text isEqual:text]) {
                
                CGFloat paddingLeft = 0.0;
                if (tableView.style == UITableViewStyleGrouped) {
                    paddingLeft = tableView.frame.size.width >= 400.0 ? 20.0 : 10.0;
                }
                
                CGRect r = _textViewCell.textView.frame;
                r.size.width = tableView.frame.size.width - (paddingLeft * 2);
                _textViewCell.textView.frame = r;
                
                _textViewCell.textView.text = text;
                if (_font) {
                    _textViewCell.textView.font = _font;
                }
                
                r.size.height = _textViewCell.textView.contentSize.height;
                _textViewCell.textView.frame = r;
                
                
                if (_textViewCell.textView.frame.size.height < 36.0f) {
                    CGRect rect = _textViewCell.textView.frame;
                    rect.size.height = 36.0f;
                    _textViewCell.textView.frame = rect;
                }
            }
            
            _currentTextViewHeight = _textViewCell.textView.contentSize.height;
            
            height = MAX(_textViewCell.textView.contentSize.height, height);
            
            if (_textViewCell.editing) {
                height += 19;
            } else {
                height += 5;
            }

        }
    }
    
    if (_minHeight > 0) {
        height = MIN(height, _minHeight);
    }
    if (_maxHeight > 0) {
        height = MAX(height, _maxHeight);
    }
	
	return height;
}

- (BOOL) hasEditor {
    return NO;
}

// hack for iOS 3 in work! Doesn't work by now!
/*
- (void) openEditorInController:(CBConfigurableTableViewController *)controller {
    if (!CBIsIOSVersionGreaterEqual(4, 0)) {
        UITextView *textView = [_textViewCell.textView retain];
        [_textViewCell.textView removeFromSuperview];
        textView.layer.cornerRadius = 3.0;
        textView.layer.borderWidth = 1.0;
        textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        textView.layer.backgroundColor = [_textViewCell.contentView.backgroundColor CGColor];
        textView.layer.opaque = YES;
        textView.userInteractionEnabled = YES;
        textView.scrollEnabled = YES;
        textView.frame = CGRectInset(_controller.tableView.frame, 3, 3);
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_controller.view addSubview:textView];
        [textView release];
    }
}*/

#pragma mark CBTextViewTableViewCellDelegate

- (void) textViewTableViewCellDidBeginEditing:(CBTextViewTableViewCell *)cell {
    if (CBIsIOSVersionGreaterEqual(4, 0)) {
        NSIndexPath *indexPath = [self.controller.model indexPathOfCell:self];
        [self.controller.tableView scrollToRowAtIndexPath:indexPath 
                                         atScrollPosition:UITableViewScrollPositionBottom
                                                 animated:YES];
    }
}

- (void) textViewTableViewCell:(CBTextViewTableViewCell *)cell didChangeTextTo:(NSString *)text {
    if (CBIsIOSVersionGreaterEqual(4, 0) && _currentTextViewHeight != cell.textView.contentSize.height) {
        [self.controller.tableView beginUpdates];
        [self.controller.tableView endUpdates];
    }
}

@end
