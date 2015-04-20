//
//  Model.h
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface Model : NSObject
+ (int)getTableNum;
+ (NSString*)getTableNameForRow:(int)row;
+ (NSArray*)getColumnNames:(NSString*)tableName;
+ (int)getRowCount:(NSString*)tableName;
+ (void)getAllData;
+ (void)insertData;
+ (void)updateData;
+ (void)gettingRowCount;

@end
