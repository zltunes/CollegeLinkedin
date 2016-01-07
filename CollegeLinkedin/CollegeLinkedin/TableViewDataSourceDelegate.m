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

@property (nonatomic,strong) NSArray                         * items;
@property (nonatomic,copy  ) NSString                        * cellIdentifier;
@property (nonatomic,strong) TableViewCellConfigureCellBlock configureCellBlock;
@property (nonatomic,strong) CellHeightBlock                 heightConfigureBlock;
@property (nonatomic,strong) DidSelectCellBlock              didSelectCellBlock;

@end

@implementation TableViewDataSourceDelegate

-(id)init
{
    return nil;
}

-(id)initWithItems:(NSArray *)anItems
    cellIdentifier:(NSString *)aCellIdentifier
configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
   cellHeightBlock:(CellHeightBlock)aHeightBlock
    didSelectBlock:(DidSelectCellBlock)aDidSelectBlock
{
    self = [super init];
    if (self) {
        self.items                = anItems;
        self.cellIdentifier       = aCellIdentifier;
        self.configureCellBlock   = aConfigureCellBlock;
        self.heightConfigureBlock = aHeightBlock;
        self.didSelectCellBlock   = aDidSelectBlock;
    }
    return self;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger)indexPath.row];
}

-(void)HandleTableViewDataSourceAndDelegate:(UITableView *)table
{
    table.delegate   = self;
    table.dataSource = self;
}

#pragma --
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    if(!cell){
        //如果tableview没有执行regisgter nib,cell无法复用的时候:
        [UITableViewCell registerTable:tableView nibIdentifier:self.cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    }
    
    //执行block进行初始化,回调在vc
    self.configureCellBlock(indexPath,item,cell);
    return cell;
}

#pragma --
#pragma mark - UITableViewDelegate
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
