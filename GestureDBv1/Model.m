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
//    NSLog(@"%@", columnNames);
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

+ (NSString*)getValueForTableName:(NSString *)tableName Column:(int)column Row:(int)row Order:(NSString *)order ColumnName:(NSString *)columnName {
//    NSArray *temp = [self getAllData:@"Album"];
    NSString *cellValue;
    if (!order) {
        cellValue = [self getAllData:tableName][column][row];
    } else if ([order isEqualToString:@"ASC"]) {
        cellValue = [self getAllDataAscWithTableName:tableName ColumnName:columnName][column][row];
    } else if ([order isEqualToString:@"DESC"]) {
        cellValue = [self getAllDataDescWithTableName:tableName ColumnName:columnName][column][row];
    }
//    return @"Hello World";
    return cellValue;
}

+ (NSArray*)getAllData:(NSString *)tableName {
    // Getting the database path.
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [sqlSelect stringByAppendingString:tableName];
    int outerLength = [self getRowCountWithTableName:tableName];
    NSMutableArray *outerArray = [[NSMutableArray alloc] initWithCapacity:outerLength];
    int innerLength = [[self getColumnNamesWithTableName:tableName] count];
    for (int i = 0; i < outerLength; i++) {
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:innerLength];
        outerArray[i] = innerArray;
    }
    

    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    for (int i = 0; i < outerLength ; i++) {
        
        [results next];
        for (int j = 0; j < innerLength; j++) {
            outerArray[i][j] = [[NSString alloc] initWithData:[results dataForColumnIndex:j] encoding:NSUTF8StringEncoding];
            
        }
        
    }
    [results next];
    
    NSLog(@"OuterArray: %@", outerArray);
    [database close];
    return outerArray;
}

+ (NSArray*)getAllDataAscWithTableName:(NSString *)tableName ColumnName:(NSString *)columnName {
    // Getting the database path.
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [[[[sqlSelect stringByAppendingString:tableName] stringByAppendingString:@" ORDER BY "] stringByAppendingString:columnName] stringByAppendingString:@" ASC"];
    int outerLength = [self getRowCountWithTableName:tableName];
    NSMutableArray *outerArray = [[NSMutableArray alloc] initWithCapacity:outerLength];
    int innerLength = [[self getColumnNamesWithTableName:tableName] count];
    for (int i = 0; i < outerLength; i++) {
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:innerLength];
        outerArray[i] = innerArray;
    }
    
    
    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    for (int i = 0; i < outerLength ; i++) {
        
        [results next];
        for (int j = 0; j < innerLength; j++) {
            outerArray[i][j] = [[NSString alloc] initWithData:[results dataForColumnIndex:j] encoding:NSUTF8StringEncoding];
            
        }
        
    }
    [results next];
    
    NSLog(@"OuterArray: %@", outerArray);
    [database close];
    return outerArray;
}

+ (NSArray*)getAllDataDescWithTableName:(NSString *)tableName ColumnName:(NSString *)columnName {
    // Getting the database path.
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [[[[sqlSelect stringByAppendingString:tableName] stringByAppendingString:@" ORDER BY "] stringByAppendingString:columnName] stringByAppendingString:@" DESC"];
    int outerLength = [self getRowCountWithTableName:tableName];
    NSMutableArray *outerArray = [[NSMutableArray alloc] initWithCapacity:outerLength];
    int innerLength = [[self getColumnNamesWithTableName:tableName] count];
    for (int i = 0; i < outerLength; i++) {
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:innerLength];
        outerArray[i] = innerArray;
    }
    
    
    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    for (int i = 0; i < outerLength ; i++) {
        
        [results next];
        for (int j = 0; j < innerLength; j++) {
            outerArray[i][j] = [[NSString alloc] initWithData:[results dataForColumnIndex:j] encoding:NSUTF8StringEncoding];
            
        }
        
    }
    [results next];
    
    NSLog(@"OuterArray: %@", outerArray);
    [database close];
    return outerArray;
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
