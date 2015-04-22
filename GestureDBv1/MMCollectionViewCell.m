//
//  MMCollectionViewCell.m
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import "MMCollectionViewCell.h"

@implementation MMCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.adjustsFontSizeToFitWidth = true;
        self.label.numberOfLines = 0;
        
        
    }
    return self;
}



@end
