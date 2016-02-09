//
//  TableViewDataSourceDelegate.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/7.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "TableViewDataSourceDelegate.h"
#import "UITableViewCell+Extension.h"
#import "TableViewSection.h"

@interface TableViewDataSourceDelegate()

@property (nonatomic,strong) NSArray                         * sections;
@property (nonatomic,strong) TableViewCellConfigureCellBlock configureCellBlock;
@property (nonatomic,strong) CellHeightBlock                 heightConfigureBlock;
@property (nonatomic,strong) DidSelectCellBlock              didSelectCellBlock;
@property (nonatomic,strong) CellIdentifierBlock             identifierBlock;
@property (nonatomic,strong) DidDeselectCellBlock            didDeselectCellBlock;

@end

@implementation TableViewDataSourceDelegate

-(id)init
{
    return nil;
}

-(id)initWithSections:(NSArray *)sections
   configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
  cellIdentifierBlock:(CellIdentifierBlock)identifierBlock
      cellHeightBlock:(CellHeightBlock)aHeightBlock
       didSelectBlock:(DidSelectCellBlock)aDidSelectBlock
{
    self = [super init];
    if (self) {
        self.sections             = sections;
        self.configureCellBlock   = aConfigureCellBlock;
        self.identifierBlock      = identifierBlock;
        self.heightConfigureBlock = aHeightBlock;
        self.didSelectCellBlock   = aDidSelectBlock;
    }
    return self;
}

-(id)initWithSections:(NSArray *)sections
   configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
  cellIdentifierBlock:(CellIdentifierBlock)identifierBlock
      cellHeightBlock:(CellHeightBlock)aHeightBlock
       didSelectBlock:(DidSelectCellBlock)aDidSelectBlock
     didDeselectBlcok:(DidDeselectCellBlock)aDidDeselectBlock
{
    self = [self initWithSections:sections
               configureCellBlock:aConfigureCellBlock
              cellIdentifierBlock:identifierBlock
                  cellHeightBlock:aHeightBlock
                   didSelectBlock:aDidSelectBlock];
    self.didDeselectCellBlock = aDidDeselectBlock;
    return self;
}

-(TableViewSection*)sectionItemAtSection:(NSInteger)section
{
    return (TableViewSection*)self.sections[section];
}


-(NSArray*)rowItems:(NSInteger)section
{
    TableViewSection* sectionItem = [self sectionItemAtSection:section];
    return sectionItem.items;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* rowItems = [self rowItems:indexPath.section];
    return rowItems[(NSUInteger)indexPath.row];
}

-(NSString*)cellIdentifier:(NSIndexPath*)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    return self.identifierBlock(indexPath,item);
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
    return self.sections.count;
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
    TableViewSection* sectionItem = [self sectionItemAtSection:section];
    return sectionItem.headerHeight;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TableViewSection* sectionItem = [self sectionItemAtSection:section];
    return sectionItem.headerTitle;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    return self.heightConfigureBlock(indexPath,item);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.didSelectCellBlock(indexPath,item,cell);
}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    id item = [self itemAtIndexPath:indexPath];
//    self.didDeselectCellBlock(indexPath,item,cell);
//}

@end
