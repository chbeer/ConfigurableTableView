//
//  CBTableViewCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCell.h"

#import "CBEditor.h"

#import "CBConfigTableViewCell.h"

@implementation CBCell

@synthesize controller = _controller;
@synthesize section = _section;

@synthesize tag = _tag;

@synthesize title = _title;
@synthesize valueKeyPath = _valueKeyPath;

@synthesize editor = _editor;
@synthesize iconName = _iconName;

- (id) initWithTitle:(NSString*)title {
	if (self = [super init]) {
		_title = [title copy];
	}
	return self;
}
- (id) initWithTitle:(NSString*)title andValuePath:(NSString*)valueKeyPath {
	if (self = [self initWithTitle:title]) {
		_valueKeyPath = [valueKeyPath copy];
	}
	return self;
}

+ (id) cellWithTitle:(NSString*)title 
				valuePath:(NSString*)valueKeyPath {
	CBCell *cell = [[[self class] alloc] initWithTitle:title 
                                          andValuePath:valueKeyPath];
	return [cell autorelease];
}
+ (id) cellWithTitle:(NSString*)title 
				valuePath:(NSString*)valueKeyPath 
				   editor:(CBEditor*)editor {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.editor = editor;
	return cell;
}
+ (id) cellWithTitle:(NSString*)title 
           valuePath:(NSString*)valueKeyPath 
            iconName:(NSString*)iconName {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.iconName = iconName;
	return cell;
}
+ (id) cellWithTitle:(NSString*)title 
           valuePath:(NSString*)valueKeyPath 
            iconName:(NSString*)iconName
              editor:(CBEditor*)editor {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.iconName = iconName;
    cell.editor = editor;
	return cell;
}

- (id)applyIconName:(NSString*)iconName {
    self.iconName = iconName;
    return self;
}
- (id) applyTag:(NSString *)tag {
    self.tag = tag;
    return self;
}

- (void) dealloc {
    [_tag release], _tag = nil;

	[_title release];
	[_valueKeyPath release];
	
	[_editor release];
	
	[_iconName release], _iconName = nil;
    
    [super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"CBCell {title: %@, keyPath: %@}", _title, _valueKeyPath];
}

// returns CBCell for linking message sending
- (CBCell*) applyEditor:(CBEditor *)editor {
    self.editor = editor;
    return self;
}

#pragma mark CBCell protocol

/* Override! */
- (NSString*) reuseIdentifier {
	NSLog(@"!!! you must override reuseIdentifier in sub-cell !!!");
	return @"CBCell";
}

- (UITableViewCellStyle) tableViewCellStyle {
    return UITableViewCellStyleDefault;
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:[self tableViewCellStyle]
												   reuseIdentifier:[self reuseIdentifier]];
	
	return [cell autorelease];
}

- (id) valueFromObject:(NSObject*)object {
	if (object && _valueKeyPath) {
		return [object valueForKeyPath:_valueKeyPath];
	} else {
		return nil;
	}
}

/* Override! */
- (void) setValue:(id)value ofCell:(UITableViewCell*)cell inTableView:(UITableView*)tableView {
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	cell.textLabel.text = _title;

    if ([self hasEditor]) {
        if (![_editor isInline]) {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.editingAccessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.editingAccessoryType = UITableViewCellAccessoryNone;
    }
    
    if (_iconName) {
        cell.imageView.image = [UIImage imageNamed:_iconName];
    }
    
    if ([cell isKindOfClass:[CBConfigTableViewCell class]]) {
        CBConfigTableViewCell *cfgCell = (CBConfigTableViewCell*)cell;
        cfgCell.object = object;
        cfgCell.keyPath = _valueKeyPath;
    }
	
	if (object && _valueKeyPath) {
		id val = [object valueForKeyPath:_valueKeyPath];
		[self setValue:val ofCell:cell inTableView:tableView];
	}
    
    if ([self hasEditor] && _editor && [_editor respondsToSelector:@selector(cell:didSetupTableViewCell:withObject:inTableView:)]) {

        [_editor cell:self didSetupTableViewCell:cell withObject:object inTableView:tableView];
        
    }
}
- (CGFloat) heightForCellInTableView:(UITableView*)tableView withObject:(NSObject*)object {
	return 44;
}

- (BOOL) hasEditor {
	return _editor != NULL;
}
- (void) openEditorInController:(CBConfigurableTableViewController*)controller {
	[_editor openEditorForCell:self inController:controller];
}
- (void) setEditor:(CBEditor*)editor {
	if (_editor != editor) {
		[_editor release];
        _editor = [editor retain];
	}
}

@end

/// Utility Methods

CGFloat CBCTVCellLabelWidth(UITableView *tableView) {
	CGFloat margin = 20;
	if (tableView.style == UITableViewStyleGrouped) {
		margin += 20;
	}
	
	return tableView.frame.size.width - margin;
}