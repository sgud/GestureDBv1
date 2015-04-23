# GestureDBv1
@Description

GestureDBv1 is an iOS application that connects to a sample chinook.sqlite database (available at https://chinookdatabase.codeplex.com/). The application enables the user to view the tables and the contents of tables in the database. Furthermore, the user is able to apply a sort to the table content view with left swipes on the attribute names for an ascending sort and a right swipe for a descending sort. 

@Execution Instructions
	1) Copy the project into a directory of choice.
	2) Open the project in Xcode
	3) Choose the emulation device
	4) Navigate to the Product menu and select Run

@File Manifest (GestureDBv1)
    - AppDelegate.h, header file for AppDelegate.
    - AppDelegate.m, implementation file for AppDelegate.
    - Model.h, header file for Model.
    - Model.m, implementation file for the model. This file contains the logic used to interact with and retrieve information from the database.
    - MasterViewController.h, header file for the MasterViewController.
    - MasterViewController.m, implementation file containing the methods for managing the view of the master (left-hand side) segment of the application.
    - DetailViewController.h, header file for the DetailViewController.
    - DetailViewController.m, implementation file that manages the view of the detail view (right-hand side) segment of the application.
    - MMCollectionViewCell.h, header file for the MMCollectionViewCell.
    - MMCollectionViewCell.m, implementation file containing methods for managing the cell content and styles in the table contents view (a subview of the detail view). Also contains touch gesture (swipe) implementations.
    - GestureDatabaseView.h, header file for the GestureDatabaseView.
    - GestureDatabaseView.m, implementation file containing the formatting for the actual table contents view.
    - Main.storyboard, a storyboard containing the interface builder specifed configuration for the views, segues, and their features.
    - Images.xcassets, contains the application's image resources (App Icons and Launcher Image)
    - LaunchScreen.xib, contains the configuration of the launch screen.

@Configuration
	- Deployment target is iOS 8.2, can be modified in the project settings.
	- Application supports landscape and portrait views.
	
@Pods / Libraries
	- FMDB Framework, used to manage the database and execute transactions. More information available at https://github.com/ccgus/fmdb.
	- MMSpreadsheetView, used to generate the styling and formatting for the cells in table view. More information available at https://github.com/mutualmobile/MMSpreadsheetView.
	- libsqlite3.0.dylib, SQLite3 framework.

@Version
    1.0

@Author
    Suhas Gudhe
    Email: gudhe.1@osu.edu
