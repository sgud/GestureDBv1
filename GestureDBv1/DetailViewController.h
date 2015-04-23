//
//  DetailViewController.h
//  GestureDBv1
//
//  
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property NSString *tableName;
@end

