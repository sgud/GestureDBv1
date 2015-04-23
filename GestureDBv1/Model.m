//
//  Model.m
//  GestureDBv1
//      Represents the model aspect of the model-view-controller design. This class contains the methods necessary for retrieving
//      interacting with and retrieving information from the database.
//
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#define kSQLiteName @"Chinook_Sqlite.sqlite"

#import "Model.h"

@implementation Model

+ (int)getTableNum {
    // Contains the path to the database
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieving the number of tables in the database
    NSString *sqlSelectQuery = @"SELECT COUNT(*) FROM sqlite_master WHERE type='table'";

    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    [results next];
    int tableNum = [[results stringForColumn:@"COUNT(*)"] integerValue];
    [database close];
    return tableNum;

}

+ (NSString*)getTableNameForRow:(int)row {
    // Contains the path to the database
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieving the names of the tables in the database
    NSString *sqlSelectQuery = @"SELECT name FROM sqlite_master WHERE type='table'";
    NSMutableArray *tableNames = [[NSMutableArray alloc] initWithArray:@[]];
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    // Iterates through the results set and stores the names in in an array for retrieval
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        [tableNames addObject:name];
    }
    [database close];
    return tableNames[row];
}

+ (NSArray*)getColumnNamesWithTableName:(NSString*)tableName {
    // Contains the path to the database
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieving the attributes for a table
    NSString *sqlPragmaQuery = [NSString stringWithFormat:@"PRAGMA table_info(%@)",tableName];
    
    NSMutableArray *columnNames = [[NSMutableArray alloc] initWithArray:@[]];
    // Query result
    FMResultSet *results = [database executeQuery:sqlPragmaQuery];
    // Iterates through result set and stores attribute names in an array
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        [columnNames addObject:name];
    }
    
    [database close];

    return [NSArray arrayWithArray:columnNames];
}

+ (int)getRowCountWithTableName:(NSString*)tableName {
    // Contains the path to the database
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieving the number of records in a table
    NSString *sqlSelect = @"SELECT COUNT(*) FROM ";
    NSString *sqlSelectQuery = [sqlSelect stringByAppendingString:tableName];

    NSUInteger count = [database intForQuery:sqlSelectQuery];
    [database close];

    return count;

}

+ (NSString*)getValueForTableName:(NSString *)tableName Column:(int)column Row:(int)row Order:(NSString *)order ColumnName:(NSString *)columnName {
    NSString *cellValue;
    // Stores the appropriate value for the specified cell in the view based on select query parameters (default, ASC, DESC)
    if (!order) {
        cellValue = [self getAllRecords:tableName][column][row];
    } else if ([order isEqualToString:@"ASC"]) {
        cellValue = [self getAllDataAscWithTableName:tableName ColumnName:columnName][column][row];
    } else if ([order isEqualToString:@"DESC"]) {
        cellValue = [self getAllDataDescWithTableName:tableName ColumnName:columnName][column][row];
    }

    return cellValue;
}

+ (NSArray*)getAllRecords:(NSString *)tableName {
    // Contains the path to the database
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieves all records in the table
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [sqlSelect stringByAppendingString:tableName];
    int outerLength = [self getRowCountWithTableName:tableName];
    NSMutableArray *outerArray = [[NSMutableArray alloc] initWithCapacity:outerLength];
    int innerLength = [[self getColumnNamesWithTableName:tableName] count];
    // Constructs a multidimensional array for storing the record data
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
    // Creates a multi-demensional array for storing the records
    for (int i = 0; i < outerLength; i++) {
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:innerLength];
        outerArray[i] = innerArray;
    }
    
    
    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    // Stores the record data in the multi-dimensional array
    for (int i = 0; i < outerLength ; i++) {
        
        [results next];
        for (int j = 0; j < innerLength; j++) {
            outerArray[i][j] = [[NSString alloc] initWithData:[results dataForColumnIndex:j] encoding:NSUTF8StringEncoding];
            
        }
        
    }
    [results next];
    
    [database close];
    return outerArray;
}

+ (NSArray*)getAllDataDescWithTableName:(NSString *)tableName ColumnName:(NSString *)columnName {
    // Contains the database path
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kSQLiteName];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    // Query retrieves all records in ascending order
    NSString *sqlSelect = @"SELECT * FROM ";
    NSString *sqlSelectQuery = [[[[sqlSelect stringByAppendingString:tableName] stringByAppendingString:@" ORDER BY "] stringByAppendingString:columnName] stringByAppendingString:@" DESC"];
    int outerLength = [self getRowCountWithTableName:tableName];
    NSMutableArray *outerArray = [[NSMutableArray alloc] initWithCapacity:outerLength];
    int innerLength = [[self getColumnNamesWithTableName:tableName] count];
    // Creates multi-dimensional array for storing the records
    for (int i = 0; i < outerLength; i++) {
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:innerLength];
        outerArray[i] = innerArray;
    }
    
    
    // Query result
    FMResultSet *results = [database executeQuery:sqlSelectQuery];
    // Stores the records in the multi-dimensional array
    for (int i = 0; i < outerLength ; i++) {
        [results next];
        for (int j = 0; j < innerLength; j++) {
            outerArray[i][j] = [[NSString alloc] initWithData:[results dataForColumnIndex:j] encoding:NSUTF8StringEncoding];
            
        }
        
    }
    [results next];
    [database close];
    
    return outerArray;
}

@end
