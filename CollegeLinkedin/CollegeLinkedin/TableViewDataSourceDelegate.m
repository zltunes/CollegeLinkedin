//
//  TableViewDataSourceDelegate.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/7.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "TableViewDataSourceDelegate.h"
#import "UITableViewCell+Extension.h"

@interface TableViewDataSourceDelegate()

@property (nonatomic,strong) NSDictionary                         * tableItems;
@property (nonatomic,strong) TableViewCellConfigureCellBlock configureCellBlock;
@property (nonatomic,strong) CellHeightBlock                 heightConfigureBlock;
@property (nonatomic,strong) DidSelectCellBlock              didSelectCellBlock;

@end

@implementation TableViewDataSourceDelegate

-(id)init
{
    return nil;
}

-(id)initWithItems:(NSDictionary *)anItems
configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
   cellHeightBlock:(CellHeightBlock)aHeightBlock
    didSelectBlock:(DidSelectCellBlock)aDidSelectBlock
{
    self = [super init];
    if (self) {
        self.tableItems           = anItems;
        self.configureCellBlock   = aConfigureCellBlock;
        self.heightConfigureBlock = aHeightBlock;
        self.didSelectCellBlock   = aDidSelectBlock;
    }
    return self;
}

-(NSArray*)rowItems:(NSInteger)section
{
    return self.tableItems[@"items"][section];
}

-(NSString*)cellIdentifier:(NSIndexPath*)indexPath
{
    return self.tableItems[@"identifier"][indexPath.section];
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* rowItems = [self rowItems:indexPath.section];
    return rowItems[(NSUInteger)indexPath.row];
}

-(void)HandleTableViewDataSourceAndDelegate:(UITableView *)table
{
    table.delegate   = self;
    table.dataSource = self;
}

#pragma --
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ((NSArray*)self.tableItems[@"items"]).count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* rowItems = [self rowItems:section];
    return rowItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [self cellIdentifier:indexPath];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    if(!cell){
        //如果tableview没有执行regisgter nib,cell无法复用的时候:
        [UITableViewCell registerTable:tableView nibIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    //执行block进行初始化,回调在vc
    self.configureCellBlock(indexPath,item,cell);
    return cell;
}

#pragma --
#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray* headerHeights = self.tableItems[@"sectionHeaderHeight"];
    CGFloat height =  (CGFloat)([headerHeights[section] floatValue]);
    return  height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    return self.heightConfigureBlock(indexPath,item);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    self.didSelectCellBlock(indexPath,item);
}

@end
