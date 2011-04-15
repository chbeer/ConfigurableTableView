//
//  CBCellStringTextView.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 08.03.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCell.h"
#import "CBEditableTableViewCell.h"

#import "CBTextViewTableViewCell.h"

@interface CBCellStringInlineEditor : CBCell <CBTextViewTableViewCellDelegate> {
	NSObject *_object;
	
	BOOL _multiline;
	UIFont *_font;
    
    float _minHeight;
    float _maxHeight;
    
    float _currentTextViewHeight;
    
    UIKeyboardType _keyboardType;
	UITextAutocorrectionType _autocorrectionType;
    UITextAutocapitalizationType _autocapitalizationType;
    
    CBTextViewTableViewCell *_textViewCell;
}

@property (nonatomic, assign) BOOL multiline;
@property (nonatomic, retain) UIFont *font;

@property (nonatomic, assign) float minHeight;
@property (nonatomic, assign) float maxHeight;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;

+ (CBCellStringInlineEditor*) cellMultilineWithValuePath:(NSString*)path;

- (UITableViewCell*) createTextView;

@end
