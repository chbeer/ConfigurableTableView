Configurable Table View
=======================

A Configurable Table View is a UITableView extension for iOS (universal) based on a lightweight model structure. It defines the sections and cells in the table. There are different cells for different types of data like text, numeric, boolean, etc. Each cell knows how to display the data. You can also very easily add your own cell types for special cells. 

Each cell has a keyValuePath it uses to access the data it displays. The data object this keyValuePath accesses is set at the Configurable Table View.

By adding an editor to a cell, the cell get's editable. There are different types of editors for different types of data. For example numeric data can either be entered using the numeric keyboard or by a slider with defined min and max values.

Cells can also be added and removed from the table model and the UITableView is updated automagically.

The sample project shows some cells and how they are configured in the model.


Install
=======

Locate the "ConfigurableTableView.xcodeproj" file under "ConfigurableTableView/src". Drag ConfigurableTableView.xcodeproj and drop it onto the root of your Xcode project's "Groups and Files" sidebar. A dialog will appear -- make sure "Copy items" is unchecked and "Reference Type" is "Relative to Project" before clicking "Add".

Now you need to link the ConfigurableTableView static library to your project. Click the "ConfigurableTableView.xcodeproj" item that has just been added to the sidebar. Under the "Details" table, you will see a single item: libConfigurableTableView.a. Check the checkbox on the far right of libConfigurableTableView.a.

Now you need to add ConfigurableTableView as a dependency of your project, so Xcode compiles it whenever you compile your project. Expand the "Targets" section of the sidebar and double-click your application's target. Under the "General" tab you will see a "Direct Dependencies" section. Click the "+" button, select "ConfigurableTableView", and click "Add Target".

Now you need to add the bundle of images and strings to your app. Locate "ConfigurableTableView.bundle" under "ConfigurableTableView/src" and drag and drop it into your project. A dialog will appear -- make sure "Create Folder References" is selected, "Copy items" is unchecked, and "Reference Type" is "Relative to Project" before clicking "Add". 

Now you need to add the Core Animation framework to your project. Right click on the "Frameworks" group in your project (or equivalent) and select Add > Existing Frameworks. Then locate QuartzCore.framework and add it to the project.

Finally, we need to tell your project where to find the ConfigurableTableView headers. Open your "Project Settings" and go to the "Build" tab. Look for "Header Search Paths" and double-click it. Add the relative path from your project's directory to the "ConfigurableTableView/src/CBConfigurableTableView" directory.

While you are in Project Settings, go to "Other Linker Flags" under the "Linker" section, and add "-ObjC" and "-all_load" to the list of flags.


Example
=======

The following example initializes the subclass of CBConfigurableTableView and adds a section with four cells:

	- (id)init {
	    self = [super initWithStyle:UITableViewStyleGrouped];
	    if (!self) return nil;
	
	    CBTable *model = [CBTable tableWithSections:
							[CBSection sectionWithTitle:@"Strings"
											   andCells:
								[CBCellString cellWithTitle:@"Name" valuePath:@"name"],
								[CBCellString cellWithTitle:@"First Name" valuePath:@"firstName"],
								[CBCellPassword cellWithTitle:@"Password" valuePath:@"password" 
													   editor:[CBEditorPassword editor]],
								[CBCellString cellMultilineWithValuePath:@"description"],
								nil],
							nil];
					         
	    self.model = model;
	    self.data = [NSMutableDictionary dictionary];
	        
	    return self;
	}