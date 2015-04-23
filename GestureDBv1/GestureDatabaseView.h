//
//  GestureDatabaseView.h
//  GestureDBv1
//
//  
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureDatabaseView : UIView
- (instancetype)initWithFrame:(CGRect)frame TableName:(NSString*)tableName;
@property NSString *order;
@property NSString *columnName;
- (void)updateTableWithColumnName:(NSString *)columnName Order:(NSString *)order;
@end
