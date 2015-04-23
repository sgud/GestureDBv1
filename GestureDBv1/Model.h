//
//  Model.h
//  GestureDBv1
//
//  
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
+ (NSString*)getValueForTableName:(NSString *)tableName Column:(int)column Row:(int)row Order:(NSString *)order ColumnName:(NSString *)columnName;
+ (NSArray*)getAllRecords:(NSString *)tableName;
+ (NSArray*)getAllDataAscWithTableName:(NSString *)tableName ColumnName:(NSString *)columnName;
+ (NSArray*)getAllDataDescWithTableName:(NSString *)tableName ColumnName:(NSString *)columnName;

@end
