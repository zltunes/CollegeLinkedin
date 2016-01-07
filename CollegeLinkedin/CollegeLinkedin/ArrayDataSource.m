
//
//  ArrayDataSource.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/6.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource ()

@property(nonatomic,strong) NSArray* items;
@property(nonatomic,copy) NSString* cellIdentifier;
@property(nonatomic,copy) TableViewCellConfigureBlock configureCellBlock;

@end


@implementation ArrayDataSource

-(id)init{
    return nil;
}

-(id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock{
    self = [super init];
    if(self){
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return _items[(NSUInteger)indexPath.row];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell,item);
    return cell;
}

@end
