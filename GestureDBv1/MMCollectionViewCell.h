//
//  MMCollectionViewCell.h
//  GestureDBv1
//
//  
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
