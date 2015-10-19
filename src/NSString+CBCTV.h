//
//  NSString+CBCTV.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 19.10.15.
//
//

#import <UIKit/UIKit.h>

@interface NSString (CBCTV)

- (CGSize) cbctv_sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
