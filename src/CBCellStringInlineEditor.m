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
		cell = [[CBTextFieldTableViewCell alloc] initWithReuseIdentifier:[self reuseIdentifier] 
                                                                 andLabel:self.title];
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
            
            CGFloat paddingLeft = 0.0;
            if (tableView.style == UITableViewStyleGrouped) {
                paddingLeft = tableView.frame.size.width >= 400.0 ? 20.0 : 10.0;
            }
        
            NSString *text = [object valueForKeyPath:self.valueKeyPath];
            
            CGSize size = [text sizeWithFont:_textViewCell.textView.font
                             constrainedToSize:CGSizeMake(tableView.frame.size.width - (paddingLeft * 2), 1000)
                                 lineBreakMode:NSLineBreakByWordWrapping];
            
            height = size.height + 20;
            
            if (_textViewCell.textView.isFirstResponder) {
                height += _textViewCell.textView.font.pointSize + 10;
            }
            
            height = MAX(height, CBCTVIsIPad() ? 55 : 44);
            
            _currentTextViewHeight = height;

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

#pragma mark CBTextViewTableViewCellDelegate

- (void) textViewTableViewCellDidBeginEditing:(CBTextViewTableViewCell *)cell {
    if (CBIsIOSVersionGreaterEqual(4, 0)) {
        NSIndexPath *indexPath = [[self.controller model] indexPathOfCell:self];
        [[self.controller tableView] scrollToRowAtIndexPath:indexPath
                                           atScrollPosition:UITableViewScrollPositionBottom
                                                 animated:YES];
    }
}

- (void) textViewTableViewCell:(CBTextViewTableViewCell *)cell didChangeTextTo:(NSString *)text {
    if (CBIsIOSVersionGreaterEqual(4, 0) && _currentTextViewHeight != cell.textView.contentSize.height) {
        [[self.controller tableView] beginUpdates];
        [[self.controller tableView] endUpdates];
    }
}

@end
