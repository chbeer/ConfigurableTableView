//
//  CBTextViewTableViewCell.h
//
//  Created by Christian Beer on 20.07.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CBConfigTableViewCell.h"

@class CBTextViewTableViewCell;

@protocol CBTextViewTableViewCellDelegate <NSObject>

@optional

- (void) textViewTableViewCellDidBeginEditing:(CBTextViewTableViewCell*)cell;
- (void) textViewTableViewCell:(CBTextViewTableViewCell*)cell didChangeTextTo:(NSString*)text;

- (void)textViewTableViewCell:(CBTextViewTableViewCell*)cell didChangeSelection:(UITextView *)textView;

@end


@interface CBTextViewTableViewCell : CBConfigTableViewCell <UITextViewDelegate> {
    id<CBTextViewTableViewCellDelegate> _delegate;

	UITextView *_textView;
    
    UIKeyboardType _keyboardType;
	UITextAutocorrectionType _autocorrectionType;
    UITextAutocapitalizationType _autocapitalizationType;
}

@property (nonatomic, assign) id<CBTextViewTableViewCellDelegate> delegate;

@property (nonatomic, readonly) UITextView *textView;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;


- (id)initWithReuseIdentifier:(NSString *)identifier andLabel:(NSString*)label;
- (void)stopEditing;

- (void) addDoneToolbarInputAccessoryView;

@end
