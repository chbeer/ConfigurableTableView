//
//  NSString+CBCTV.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 19.10.15.
//
//

#import "NSString+CBCTV.h"

@implementation NSString (CBCTV)

- (CGSize) cbctv_sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)constrain lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = lineBreakMode;
    CGSize size = [self boundingRectWithSize:constrain
                                     options:NSStringDrawingUsesDeviceMetrics|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName:font,
                                               NSParagraphStyleAttributeName: style
                                               }
                                     context:nil].size;
    return size;
}

@end
