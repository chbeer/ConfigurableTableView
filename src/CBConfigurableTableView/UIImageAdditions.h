
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CBCTVAddition)

/*
 * Resizes and/or rotates an image.
 */
- (UIImage*)cbctvTransformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

- (CGRect)cbctvConvertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image using content mode rules.
 */
- (void)cbctvDrawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image as a rounded rectangle.
 */
- (void)cbctvDrawInRect:(CGRect)rect radius:(CGFloat)radius;
- (void)cbctvDrawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode;

@end
