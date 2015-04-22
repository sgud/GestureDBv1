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
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];

    NSString *sqlSelectQuery = @"SELECT COUNT(*) FROM sqlite_master WHERE type='table'";
//    NSString *sqlSelectQuery = @"SELECT name FROM sqlite_master WHERE type='table'";

    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    [results next];
    int tableNum = [[results stringForColumn:@"COUNT(*)"] integerValue];
    [database close];
    return tableNum;

}

+ (NSString*)getTableNameForRow:(int)row {

    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
//    NSString *sqlSelectQuery = @"SELECT COUNT(*) FROM sqlite_master WHERE type='table'";
    NSString *sqlSelectQuery = @"SELECT name FROM sqlite_master WHERE type='table'";
    NSMutableArray *tableNames = [[NSMutableArray alloc] initWithArray:@[]];
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        [tableNames addObject:name];
    }
//    NSLog(@"%@", tableNames);
    [database close];
    return tableNames[row];
}

+ (NSArray*)getColumnNamesWithTableName:(NSString*)tableName {
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlPragmaQuery = [NSString stringWithFormat:@"PRAGMA table_info(%@)",tableName];
//    NSString *sqlSelectQuery = [NSString stringWithFormat:@"SELECT sql FROM sqlite_master WHERE tbl_name = '%@' AND type = 'table'",@"Album"];
    
    NSMutableArray *columnNames = [[NSMutableArray alloc] initWithArray:@[]];
    // Query result
    FMResultSet *results = [database executeQuery:sqlPragmaQuery];
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        [columnNames addObject:name];
    }
    
    [database close];
//    NSLog(@"TableName: %@", tableName);
    NSLog(@"%@", columnNames);
    return [NSArray arrayWithArray:columnNames];
}

+ (int)getRowCountWithTableName:(NSString*)tableName {
    
//    int temp = [[self getAllData:tableName] count];
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelect = @"SELECT COUNT(*) FROM ";
    NSString *sqlSelectQuery = [sqlSelect stringByAppendingString:tableName];
    //    NSString *sqlSelectQuery = @"SELECT name FROM sqlite_master WHERE type='table'";
    
//    FMResultSet *results = [database executeQuery:sqlSelectQuery];
//    [results next];
    NSUInteger count = [database intForQuery:sqlSelectQuery];
    [database close];
//    NSLog(@"%@", count);
    return count;
//    return 3;
}

+ (NSString*)getValueForColumn:(int)column Row:(int)row {
    return @"Hello World";
}

+ (NSArray*)getAllData:(NSString *)tableName {
    // Getting the database path.
//    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
   
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [sqlSelect stringByAppendingString:tableName];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:@[]];
    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    while([results next]) {
        
        
        
//        NSString *strID = [NSString stringWithFormat:@"%d",[resultsWithNameLocation intForColumn:@"ID"]];
//        NSString *strName = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Name"]];
//        NSString *strLoc = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Location"]];
        
       
//        dataArray addObject:<#(id)#>;
        
        // loading your data into the array, dictionaries.
//        NSLog(@"ID = %@, Name = %@, Location = %@",strID, strName, strLoc);
    }
    [database close];
    return @[];
}



//+ (void)insertData {
//    
//    // Getting the database path.
//    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO user VALUES ('%@', %d)", @"Jobin Kurian", 25];
//    [database executeUpdate:insertQuery];
//    [database close];
//}
//
//+ (void)updateData {
//    
//    // Getting the database path.
//    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    NSString *insertQuery = [NSString stringWithFormat:@"UPDATE users SET age = '%@' WHERE username = '%@'", @"23", @"colin" ];
//    [database executeUpdate:insertQuery];
//    [database close];
//}
//
//+ (void)gettingRowCount {
//    
//    // Getting the database path.
//    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *dbPath = [docsPath stringByAppendingPathComponent:kSQLiteName];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    NSUInteger count = [database intForQuery:@"SELECT COUNT(field_name) FROM table_name"];
//    [database close];
//}

@end
