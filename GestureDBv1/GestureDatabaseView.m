//
//  GestureDatabaseView.m
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import "GestureDatabaseView.h"
#import "Model.h"
#import "MMGridLayout.h"
#import "MMSpreadsheetView.h"
#import "MMCollectionViewCell.h"
#import "NSIndexPath+MMSpreadsheetView.h"

@interface GestureDatabaseView () <MMSpreadsheetViewDataSource , MMSpreadsheetViewDelegate>
@property NSString *tableName;
@property MMSpreadsheetView *spreadSheetView;
@end


@implementation GestureDatabaseView

- (instancetype)initWithFrame:(CGRect)frame TableName:(NSString*)tableName {
    if (self=[super initWithFrame:frame]) {
        NSAssert(tableName != nil, @"Table name is null");
        self.tableName = tableName;
        // Create the spreadsheet in code.
        self.spreadSheetView = [[MMSpreadsheetView alloc] initWithNumberOfHeaderRows:1 numberOfHeaderColumns:1 frame:self.bounds];
        
        // Register your cell classes.
        [self.spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"GridCell"];
        [self.spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"TopRowCell"];
        [self.spreadSheetView registerCellClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:@"LeftColumnCell"];
        
        // Set the delegate & datasource spreadsheet view.
        self.spreadSheetView.delegate = self;
        self.spreadSheetView.dataSource = self;
        
        // Add the spreadsheet view as a subview.
        [self addSubview:self.spreadSheetView];
        
    }
    return self;
}

- (NSInteger)numberOfColumnsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView {
    NSAssert(self.tableName != nil, @"Table name is null");
    int temp = [Model getRowCountWithTableName:self.tableName];
    NSLog(@"Column: %i",temp);
    return temp + 1;
}

- (NSInteger)numberOfRowsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView {
    NSAssert(self.tableName != nil, @"Table name is null");
   int temp = [[Model getColumnNamesWithTableName:self.tableName] count];
    
    NSLog(@"Row: %i",temp);
    return temp + 1;
}

- (CGSize)spreadsheetView:(MMSpreadsheetView *)spreadsheetView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat leftColumnWidth = 320.0f;
    CGFloat topRowHeight = 150.0f;
    CGFloat gridCellWidth = 124.0f;
    CGFloat gridCellHeight = 103.0f;
    
    // Upper left.
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 0) {
        return CGSizeMake(leftColumnWidth, topRowHeight);
    }
    
    // Upper right.
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn > 0) {
        return CGSizeMake(gridCellWidth, topRowHeight);
    }
    
    // Lower left.
    if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 0) {
        return CGSizeMake(leftColumnWidth, gridCellHeight);
    }
    
    return CGSizeMake(gridCellWidth, gridCellHeight);
}

- (UICollectionViewCell *)spreadsheetView:(MMSpreadsheetView *)spreadsheetView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 0) {
        // Upper left.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMCollectionViewCell *gc = (MMCollectionViewCell *)cell;
        gc.label.text = self.tableName;
//        cell.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    }
    else if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn > 0) {
        // Upper right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"TopRowCell" forIndexPath:indexPath];
        MMCollectionViewCell *tr = (MMCollectionViewCell *)cell;
        tr.label.text = @""; //-1
        cell.backgroundColor = [UIColor whiteColor];
    }
    else if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 0) {
        // Lower left.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"LeftColumnCell" forIndexPath:indexPath];
        MMCollectionViewCell *lc = (MMCollectionViewCell *)cell;
        NSLog(@"Index path is: %i \nColumn names: %@", indexPath.mmSpreadsheetRow - 1,[Model getColumnNamesWithTableName:self.tableName]);
        
        lc.label.text = [Model getColumnNamesWithTableName:self.tableName][indexPath.mmSpreadsheetRow - 1];
        BOOL isDarker = indexPath.mmSpreadsheetRow % 2 == 0;
        if (isDarker) {
            cell.backgroundColor = [UIColor colorWithRed:222.0f / 255.0f green:243.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:233.0f / 255.0f green:247.0f / 255.0f blue:252.0f / 255.0f alpha:1.0f];
        }
    }
    else {
        // Lower right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMCollectionViewCell *gc = (MMCollectionViewCell *)cell;

        gc.label.text = [Model getValueForTableName:self.tableName Column:indexPath.mmSpreadsheetColumn - 1 Row:indexPath.mmSpreadsheetRow - 1];
        BOOL isDarker = indexPath.mmSpreadsheetRow % 2 == 0;
        if (isDarker) {
            cell.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
        }
    }
    return cell;
}


@end



