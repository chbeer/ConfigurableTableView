//
//  CBCTVGlobal.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBConfigurableTableView/CBCTVGlobal.h"

NSString* CBCTVBundlePath() {
	NSString* path = [[[NSBundle mainBundle] resourcePath]
					  stringByAppendingPathComponent:@"ConfigurableTableView.bundle"];
	return path;
}

NSBundle* CBCTVBundle() {
	static NSBundle* bundle = nil;
	if (!bundle) {
		bundle = [[NSBundle bundleWithPath:CBCTVBundlePath()] retain];
	}
	return bundle;
}

NSString* CBCTVLocalizedString(NSString *key) {
	return [CBCTVBundle() localizedStringForKey:key value:key table:nil];
}

UIImage *CBCTVImageNamed(NSString *img) {
	NSString *path = [CBCTVBundlePath() stringByAppendingPathComponent:img];
	NSData *data = [NSData dataWithContentsOfFile:path];
	return [UIImage imageWithData:data];
}

void CBCGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) {
	CGFloat width = CGRectGetWidth(rect);
	CGFloat height = CGRectGetHeight(rect);
	
	// Make sure corner radius isn't larger than half the shorter side
	if (radius > width/2.0)
		radius = width/2.0;
	if (radius > height/2.0)
		radius = height/2.0;    
	
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}


//// Image resize //////

///// Image rescale ///////////

CGSize CBCGSizeWithAspectRatio(CGSize dest, CGSize ratio) {
    CGSize result;
    if (ratio.width > ratio.height) {
        CGFloat ar = ratio.height / ratio.width;
        result.width = dest.width;
        result.height = ceil(dest.width * ar);
    } else {
        CGFloat ar = ratio.width / ratio.height;
        result.height = dest.height;
        result.width = ceil(dest.height * ar);
    }
    return result;
}

CGSize CBCGSizeFitToSize(CGSize src, CGSize max) {
    CGSize result;
    if (src.width > src.height) { // landscape
        CGFloat factor = max.width / src.width;
        if (src.width > max.width) {
            result.width = max.width;
            result.height = floor(src.height * factor);
        } else {
            result = src;
        }
        if (result.height > max.height) {
            CGFloat ar = result.height / result.width;
            result.height = max.height;
            result.width = floor(result.height / ar);
        }
    } else {
        CGFloat factor = max.height / src.height;
        if (src.height > max.height) {
            result.height = max.height;
            result.width = floor(src.width * factor);
        } else {
            result = src;
        }
        if (result.width > max.width) {
            CGFloat ar = result.width / result.height;
            result.width = max.width;
            result.height = floor(result.width / ar);
        }
    }
    return result;
}

UIImage *CBUIImageScale(UIImage *img, CGSize dest) {
    UIGraphicsBeginImageContext(dest);
    [img drawInRect:(CGRect){CGPointZero, dest}];
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}


BOOL CBCTVIsIPad() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


BOOL CBIsIOSVersionGreaterEqual(int checkMaj, int checkMin) {
    static int maj = -1, min = -1;
    
    if (maj == -1 && min == -1) {
        NSString *osVersion = [[UIDevice currentDevice] systemVersion];
        NSArray *components = [osVersion componentsSeparatedByString:@"."];
        maj = [[components objectAtIndex:0] intValue];
        min = [[components objectAtIndex:1] intValue];
    }
    
    if (maj < checkMaj) return NO;
    if (min < checkMin) return NO;
    
    return YES;
}



@implementation UIColor (CBConfigurableTableView) 

+ (UIColor*) tableViewCellValueTextColor {
    return [UIColor colorWithRed:0.220 green:0.329 blue:0.529 alpha:1.000];
}

@end 