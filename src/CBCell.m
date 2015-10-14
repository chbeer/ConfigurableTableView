//
//  CBTableViewCell.m
//  ConfigurableTableView
//
//  Created by Christian Beer on 04.12.09.
//  Copyright 2010 Christian Beer. All rights reserved.
//

#import "CBCell.h"

#import "CBCTVGlobal.h"
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

@synthesize font = _font;
@synthesize detailFont = _detailFont;

@synthesize icon = _icon;
@synthesize iconName = _iconName;

@synthesize enabled = _enabled;

@synthesize nibReuseIdentifier = nibReuseIdentifier;

- (instancetype) initWithTitle:(NSString*)title {
	if (self = [super init]) {
		_title = [title copy];
        _style = UITableViewCellStyleDefault;
        _enabled = YES;
	}
	return self;
}
- (instancetype) initWithTitle:(NSString*)title andValuePath:(NSString*)valueKeyPath {
	if (self = [self initWithTitle:title]) {
		_valueKeyPath = [valueKeyPath copy];
	}
	return self;
}

+ (instancetype) cellWithTitle:(NSString*)title
                     valuePath:(NSString*)valueKeyPath {
	CBCell *cell = [[[self class] alloc] initWithTitle:title 
                                          andValuePath:valueKeyPath];
	return cell;
}
+ (instancetype) cellWithTitle:(NSString*)title
                     valuePath:(NSString*)valueKeyPath
                        editor:(CBEditor*)editor {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.editor = editor;
	return cell;
}
+ (instancetype) cellWithTitle:(NSString*)title
                     valuePath:(NSString*)valueKeyPath
                      iconName:(NSString*)iconName {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.iconName = iconName;
	return cell;
}
+ (instancetype) cellWithTitle:(NSString*)title
                     valuePath:(NSString*)valueKeyPath
                      iconName:(NSString*)iconName
                        editor:(CBEditor*)editor {
	CBCell *cell = [self cellWithTitle:title valuePath:valueKeyPath];
	cell.iconName = iconName;
    cell.editor = editor;
	return cell;
}

+ (instancetype) cellWithNibReuseIdentifier:(NSString*)nibReuseIdentifier valuePath:(NSString*)valueKeyPath
{
    CBCell *cell = [self cellWithTitle:nil valuePath:valueKeyPath];
	cell.nibReuseIdentifier = nibReuseIdentifier;
	return cell;
}

- (instancetype)applyFont:(UIFont*)font {
    self.font = font;
    return self;
}
- (instancetype)applyDetailFont:(UIFont*)font {
    self.detailFont = font;
    return self;
}

- (instancetype) applyIcon:(UIImage*)icon;
{
    self.icon = icon;
    return self;
}
- (instancetype)applyIconName:(NSString*)iconName {
    self.iconName = iconName;
    return self;
}
- (instancetype) applyTag:(NSString *)tag {
    self.tag = tag;
    return self;
}
- (instancetype) applyStyle:(UITableViewCellStyle)style;
{
    self.style = style;
    return self;
}
- (instancetype) applyEnabled:(BOOL)enabled;
{
    self.enabled = enabled;
    return self;
}

- (instancetype) applyNibReuseIdentifier:(NSString*)reuseIdentifier;
{
    self.nibReuseIdentifier = reuseIdentifier;
    return self;
}

- (instancetype) applyAccessibilityLabel:(NSString*)accessibilityLabel;
{
    self.accessibilityLabel = accessibilityLabel;
    return self;
}

- (instancetype) applyValueTransformer:(CBCellValueTransformerHandler)valueTransformerHandler;
{
    self.valueTransformerHandler = valueTransformerHandler;
    return self;
}

- (instancetype) applyAccessoryButtonHandler:(CBCellAccessoryButtonHandler) accessoryButtonHandler;
{
    self.accessoryButtonHandler = accessoryButtonHandler;
    return self;
}

- (void) dealloc {
    _tag = nil;

	

	_icon = nil;
	_iconName = nil;
    
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@ {title: %@, keyPath: %@, tag: %@}", NSStringFromClass([self class]), _title, _valueKeyPath, _tag];
}

// returns CBCell for linking message sending
- (CBCell*) applyEditor:(CBEditor *)editor {
    self.editor = editor;
    return self;
}

#pragma mark CBCell protocol

- (NSString*) reuseIdentifier {
    // return different reuse identifier for different cell styles.
	return [NSString stringWithFormat:@"%@_%ld", NSStringFromClass([self class]), (long)self.style];
}

- (UITableViewCellStyle) tableViewCellStyle {
    return self.style;
}
- (Class) tableViewCellClass {
    return [UITableViewCell class];
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView {
    if (self.nibReuseIdentifier) {
        return [tableView dequeueReusableCellWithIdentifier:self.nibReuseIdentifier];
    }
    
	UITableViewCell *cell = [[[self tableViewCellClass] alloc] initWithStyle:[self tableViewCellStyle]
                                                             reuseIdentifier:[self reuseIdentifier]];
	
	return cell;
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
    cell.accessibilityLabel = self.accessibilityLabel;

    if (_font) {
		cell.textLabel.font = _font;
	}
    if (_detailFont) {
		cell.detailTextLabel.font = _detailFont;
	}
    
    if (_icon) {
        cell.imageView.image = _icon;
    } else if (_iconName) {
        cell.imageView.image = [UIImage imageNamed:_iconName];
    } else {
        cell.imageView.image = nil;
    }
    
    cell.textLabel.enabled = self.enabled;
    if (!self.enabled) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([cell isKindOfClass:[CBConfigTableViewCell class]]) {
        CBConfigTableViewCell *cfgCell = (CBConfigTableViewCell*)cell;
        cfgCell.object = object;
        cfgCell.keyPath = _valueKeyPath;
    }
	
	if (object && _valueKeyPath) {
		id val = [object valueForKeyPath:_valueKeyPath];
        
        if (self.valueTransformerHandler) {
            val = self.valueTransformerHandler(val);
        }

        [self setValue:val ofCell:cell inTableView:tableView];
	}
    
    if ([self hasEditor] && _editor && [_editor respondsToSelector:@selector(cell:didSetupTableViewCell:withObject:inTableView:)]) {

        [_editor cell:self didSetupTableViewCell:cell withObject:object inTableView:tableView];
        
    } else {
        
        cell.accessoryView = nil;
        
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
        _editor = editor;
	}
}

@end

