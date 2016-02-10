//
//  CareerTable.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CareerTable.h"

@interface CareerTable ()

@property (nonatomic,strong) NSArray                     * sectionItemsArray;
@property (nonatomic,strong) NSArray                     * careersArray;

@end

@implementation CareerTable

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray*)sectionItemsArray
{

//        初始选择
        _sectionItemsArray = [NSArray array];
        TableViewSection* section = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:0 items:_careersArray];
        _sectionItemsArray = [_sectionItemsArray arrayByAddingObject:section];


    return _sectionItemsArray;
}

-(void)setUpTableView
{
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
    TableViewCellConfigureCellBlock configureCell = ^(NSIndexPath* indexPath,id obj,UITableViewCell *cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    };
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath,id item){
        return [UITableViewCell getCellHeightWithCustomObj:item indexPath:indexPath];
    };
    
    CellIdentifierBlock cellIdentifier = ^NSString*(NSIndexPath *indexPath,id item){
        return [rightCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
    };
    
    DidSelectCellBlock selectBlock = ^(NSIndexPath *indexPath,id item,UITableViewCell *cell){
        [cell didSelectCell:cell WithCustomObj:item indexPath:indexPath];
        
        self.selectedCareer = (Career*)[self.careersArray objectAtIndex:indexPath.row];
        [self.delegate didSelectCellWithCareer:self.selectedCareer andSelectedIndustry:self.selectedIndustry];
    };
    
    self.tableHandler = [[TableViewDataSourceDelegate alloc]initWithSections:[self sectionItemsArray]
                                                          configureCellBlock:configureCell
                                                         cellIdentifierBlock:cellIdentifier
                                                             cellHeightBlock:heightBlock
                                                              didSelectBlock:selectBlock];
    
    [self.tableHandler HandleTableViewDataSourceAndDelegate:self.tableView];

}

#pragma mark IndustryTableDelegate

-(void)didSelectCellWithIndustry:(Industry *)selectedIndustry
{
    self.selectedIndustry = selectedIndustry;
    [self setCareersArray:selectedIndustry.careers];
    [self setUpTableView];
}

@end
