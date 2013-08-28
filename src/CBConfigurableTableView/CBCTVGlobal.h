//
//  CBCTVGlobal.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString *CBCTVLocalizedString(NSString *key);

UIImage* CBCTVImageNamed(NSString *img);

void CBCGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);


//// Image scaling

CGSize CBCGSizeWithAspectRatio(CGSize dest, CGSize ratio);
CGSize CBCGSizeFitToSize(CGSize src, CGSize max);
UIImage *CBUIImageScale(UIImage *img, CGSize dest);


BOOL CBCTVIsIPad();
BOOL CBCTVIsIOS7();

BOOL CBIsIOSVersionGreaterEqual(int maj, int min);

CGFloat CBCTVCellLabelWidth(UITableView *tableView);


@interface UIColor (CBConfigurableTableView) 

+ (UIColor*) tableViewCellValueTextColor;

@end 