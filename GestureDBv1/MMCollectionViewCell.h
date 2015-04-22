//
//  MMCollectionViewCell.h
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureDatabaseView.h"

@interface MMCollectionViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property UILabel *label;
@property UISwipeGestureRecognizer *leftSwipe;
@property UISwipeGestureRecognizer *rightSwipe;
@property (weak) GestureDatabaseView *gdv;
@end
