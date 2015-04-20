//
//  GestureDatabaseView.m
//  GestureDBv1
//
//  Created by Suhas Gudhe on 4/19/15.
//  Copyright (c) 2015 gudhe. All rights reserved.
//

#import "GestureDatabaseView.h"
#import "Model.h"

@interface GestureDatabaseView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property NSString *tableName;
@property UILabel *label;
@property UITableView *table;
@property UICollectionView *collection;
@end


@implementation GestureDatabaseView

- (instancetype)initWithFrame:(CGRect)frame TableName:(NSString*)tableName {
    if (self=[super initWithFrame:frame]) {
        self.tableName = tableName;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        [self addSubview:self.label];
        self.table =  [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 200, 200) style:UITableViewStylePlain];
        self.table.delegate=self;
        self.table.dataSource=self;
        [self addSubview:self.table];
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(200, 50, 200, 200) collectionViewLayout:flow];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self addSubview:self.collection];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Model getColumnNames:self.tableName] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    // Checks if cell is nil, if nil creates cell
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
    }
    
    NSArray *columnNames = [Model getColumnNames:self.tableName];
    cell.textLabel.text = columnNames[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [Model getRowCount:self.tableName];
}

@end



