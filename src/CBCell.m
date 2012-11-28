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
@synthesize style = _style;

@synthesize title = _title;
@synthesize valueKeyPath = _valueKeyPath;

@synthesize editor = _editor;
@synthesize iconName = _iconName;

@synthesize enabled = _enabled;

@synthesize nibReuseIdentifier = nibReuseIdentifier;

- (id) initWithTitle:(NSString*)title {
	if (self = [super init]) {
		_title = [title copy];
        _style = UITableViewCellStyleDefault;
        _enabled = YES;
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

+ (id) cellWithNibReuseIdentifier:(NSString*)nibReuseIdentifier valuePath:(NSString*)valueKeyPath
{
    CBCell *cell = [self cellWithTitle:nil valuePath:valueKeyPath];
	cell.nibReuseIdentifier = nibReuseIdentifier;
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
- (id) applyStyle:(UITableViewCellStyle)style;
{
    self.style = style;
    return self;
}
- (id) applyEnabled:(BOOL)enabled;
{
    self.enabled = enabled;
    return self;
}

- (id) applyNibReuseIdentifier:(NSString*)reuseIdentifier;
{
    self.nibReuseIdentifier = reuseIdentifier;
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

- (NSString*) reuseIdentifier {
    // return different reuse identifier for different cell styles.
	return [NSString stringWithFormat:@"%@_%d", NSStringFromClass([self class]), self.style];
}

- (UITableViewCellStyle) tableViewCellStyle {
    return self.style;
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
    if (self.nibReuseIdentifier) {
        return [tableView dequeueReusableCellWithIdentifier:self.nibReuseIdentifier];
    }
    
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
    if ([cell respondsToSelector:@selector(setObject:)]) {
        [cell performSelector:@selector(setObject:) withObject:value];
    }
}

- (UITableViewCellAccessoryType) accessoryType
{
    if ([self hasEditor]) {
        if (![self isEditorInline]) {
            return UITableViewCellAccessoryDisclosureIndicator;
        } else {
            return UITableViewCellAccessoryNone;
        }
    } else {
        return UITableViewCellAccessoryNone;
    }
}

- (void) setupCell:(UITableViewCell*)cell withObject:(NSObject*)object inTableView:(UITableView*)tableView {
	cell.textLabel.text = _title;

    if ([self hasEditor]) {
        if (![self isEditorInline]) {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.editingAccessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editingAccessoryType = UITableViewCellAccessoryNone;
    }

    cell.accessoryType = [self accessoryType];

    if (_iconName) {
        cell.imageView.image = [UIImage imageNamed:_iconName];
    }
    
    cell.textLabel.enabled = self.enabled;
    
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
- (BOOL) isEditorInline {
    return [_editor isInline];
}

- (void) openEditorInController:(CBConfigurableTableViewController*)controller {
	[_editor openEditorForCell:self inController:controller];
}
- (void) openEditorInController:(CBConfigurableTableViewController*)controller fromTableViewCell:(UITableViewCell *)cell {
    [self openEditorInController:controller];
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