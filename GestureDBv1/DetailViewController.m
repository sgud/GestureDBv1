//
//  DetailViewController.m
//  GestureDBv1
//
//  
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import "DetailViewController.h"
#import "GestureDatabaseView.h"

@interface DetailViewController ()
@property GestureDatabaseView *gestureDatabaseView;
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

}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.tableName) {
        self.gestureDatabaseView = [[GestureDatabaseView alloc] initWithFrame:self.view.bounds TableName:self.tableName];
        [self.view addSubview:self.gestureDatabaseView];
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
