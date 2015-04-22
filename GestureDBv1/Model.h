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
+ (NSArray*)getColumnNamesWithTableName:(NSString*)tableName;
+ (int)getRowCountWithTableName:(NSString*)tableName;
+ (NSString*)getValueForTableName:(NSString *)tableName Column:(int)column Row:(int)row;
+ (void)getAllData;
+ (void)insertData;
+ (void)updateData;
+ (void)gettingRowCount;

@end
