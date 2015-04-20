//
//  Model.m
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#define kSQLiteName @"Chinook_Sqlite.sqlite"

#import "Model.h"

@implementation Model

+ (int)getTableNum {
    // Use a query to the SQL Master table where name = "table"
    return 10;
}

+ (NSString*)getTableNameForRow:(int)row {
    return @"TableName1";
}

+ (void)getAllData {
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM tablename";
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        NSString *strID = [NSString stringWithFormat:@"%d",[resultsWithNameLocation intForColumn:@"ID"]];
        NSString *strName = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Name"]];
        NSString *strLoc = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Location"]];
        
        // loading your data into the array, dictionaries.
        NSLog(@"ID = %@, Name = %@, Location = %@",strID, strName, strLoc);
    }
    [database close];
}

#import "FMDatabase.h"

+ (void)insertData {
    
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO user VALUES ('%@', %d)", @"Jobin Kurian", 25];
    [database executeUpdate:insertQuery];
    [database close];
}

+ (void)updateData {
    
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertQuery = [NSString stringWithFormat:@"UPDATE users SET age = '%@' WHERE username = '%@'", @"23", @"colin" ];
    [database executeUpdate:insertQuery];
    [database close];
}

+ (void)gettingRowCount {
    
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSUInteger count = [database intForQuery:@"SELECT COUNT(field_name) FROM table_name"];
    [database close];
}

@end
