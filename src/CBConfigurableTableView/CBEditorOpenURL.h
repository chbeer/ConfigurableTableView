//
//  CBEditorOpenLink.h
//  ConfigurableTableView
//
//  Created by Christian Beer on 01.06.10.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEditor.h"

@interface CBEditorOpenURL : CBEditor {
    NSURL *_url;
}

@property (nonatomic, copy) NSURL *url;

+ (CBEditorOpenURL*) editorWithURL:(NSURL*)url;

@end
