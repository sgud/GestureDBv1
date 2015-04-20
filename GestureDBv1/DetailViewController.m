//
//  DetailViewController.m
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import "DetailViewController.h"
#import "MMGridLayout.h"
#import "MMSpreadsheetView.h"
#import "MMCollectionViewCell.h"

@interface DetailViewController ()
@property MMSpreadsheetView *spreadSheetView;


@end



@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)addTableWithName:(NSString *)tableName {
    // Create the spreadsheet in code.
    MMSpreadsheetView *spreadSheetView = [[MMSpreadsheetView alloc] initWithNumberOfHeaderRows:1 numberOfHeaderColumns:1 frame:self.view.bounds];
    
    // Register your cell classes.
    [spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"GridCell"];
    [spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"TopRowCell"];
    [spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"LeftColumnCell"];
    
    // Set the delegate & datasource spreadsheet view.
    spreadSheetView.delegate = self;
    spreadSheetView.dataSource = self;
    
    // Add the spreadsheet view as a subview.
    [self.view addSubview:spreadSheetView];
    self.spreadSheetView = spreadSheetView;
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
