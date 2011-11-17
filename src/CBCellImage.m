//
//  CBCellImage.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 25.01.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCellImage.h"

#import "CBCTVGlobal.h"

#import "CBConfigurableTableViewController.h"

#import "CBImageEditorController.h"

@interface CBTableViewCellImage : UITableViewCell {
    CGFloat _maxHeight;
}
@property (nonatomic,assign) CGFloat maxHeight;
@end


@implementation CBCellImage

@synthesize maxHeight = _maxHeight;

- (id) initWithTitle:(NSString*)title {
	if (self = [super initWithTitle:title]) {
        _maxHeight = 0;
	}
	return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
	return @"CBCellImage";
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	CBTableViewCellImage *cell = [[CBTableViewCellImage alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier:[self reuseIdentifier]];

	return [cell autorelease];
}

- (UIImage *)thumbnailOfSize:(CGSize)size image:(UIImage*)img {
    UIGraphicsBeginImageContext(size);
	
    // draw scaled image into thumbnail context
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
	
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
	
    // pop the context
    UIGraphicsEndImageContext();
	
    if(newThumbnail == nil) {
        NSLog(@"could not scale image");
    }
	
    return newThumbnail;
}

- (void) setValue:(id)value 
		   ofCell:(UITableViewCell*)cell
	  inTableView:(UITableView*)tableView {
    
    CBTableViewCellImage *imgCell = (CBTableViewCellImage*)cell;
    
    imgCell.maxHeight = _maxHeight;
    
	if (!value) {
		cell.imageView.image = CBCTVImageNamed(@"cbCTVImages/cbctv_dummyImage.png");
	} else {
		cell.imageView.image = value;
	}
}

- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object {
    CGFloat height = 44;
    
    CGFloat imgHeight = 0;
    if (object && self.valueKeyPath) {
        UIImage *img = [object valueForKeyPath:self.valueKeyPath];
        
        if (img) {
            CGSize destSize = CGSizeMake(tableView.frame.size.width - 20, 44);
            if (_maxHeight > 0) {
                destSize.height = MIN(_maxHeight, img.size.height);
            } 
            
            CGSize imgSize = CBCGSizeFitToSize(img.size, 
                                               destSize);
                    
            imgHeight = imgSize.height;
        }
    }
    
    if (_maxHeight > 0) {
        height = MIN(_maxHeight, imgHeight);
    } else {
        height = imgHeight;
    }
    
    return MAX(height + 10, 44);
}

@end



@implementation CBTableViewCellImage

@synthesize maxHeight = _maxHeight;

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.textLabel.text && self.imageView.image) {
        CGSize destSize = self.contentView.frame.size;
        destSize.width -= 10;
        if (_maxHeight > 0) {
            destSize.height = MIN(_maxHeight, self.imageView.image.size.height);
        }
        
        CGSize imgSize = CBCGSizeFitToSize(self.imageView.image.size, 
                                           destSize);
        
        CGFloat lx = self.contentView.frame.size.width / 2 - (imgSize.width / 2);
        
        self.imageView.frame = (CGRect) {CGPointMake(lx, 5), imgSize};
    }
}

@end