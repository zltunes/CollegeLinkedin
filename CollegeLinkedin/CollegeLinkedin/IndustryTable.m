//
//  IndustryTable.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "IndustryTable.h"

@interface IndustryTable ()

@property(strong,nonatomic) NSArray* sectionItemsArray;
@property(strong,nonatomic) NSArray* industriesArray;

@property(strong,nonatomic) NSArray* jsonArray;

@end

@implementation IndustryTable

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray*)sectionItemsArray
{
    
    if (!_sectionItemsArray) {
         _sectionItemsArray = [NSArray array];//此句是必需的
        _industriesArray          = [Industry mj_objectArrayWithKeyValuesArray:[Config getIndustryArray]];
        TableViewSection* section = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:0 items:_industriesArray];
        _sectionItemsArray        = [_sectionItemsArray arrayByAddingObject:section];

    }
    
    return _sectionItemsArray;
}

-(void)setUpTableView
{
    self.tableView.tableFooterView                = [Config getTableViewFooter];

    TableViewCellConfigureCellBlock configureCell = ^(NSIndexPath* indexPath,id obj,UITableViewCell* cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    };

    CellHeightBlock heightBlock                   = ^CGFloat(NSIndexPath* indexPath,id item){
        return [UITableViewCell getCellHeightWithCustomObj:item indexPath:indexPath];
    };

    CellIdentifierBlock cellIdentifier            = ^NSString*(NSIndexPath* indexPath,id item){
        return [leftCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
    };

    DidSelectCellBlock selectBlock                = ^(NSIndexPath* indexPath,id item,UITableViewCell* cell){
        [cell didSelectCell:cell WithCustomObj:item indexPath:indexPath];
//        与vc相关事件继续写在此处
        self.selectedIndustry = (Industry*)[_industriesArray objectAtIndex:indexPath.row];
        [self.delegate didSelectCellWithIndustry:self.selectedIndustry];
    };

    self.tableHandler = [[TableViewDataSourceDelegate alloc]initWithSections:self.sectionItemsArray
                                                          configureCellBlock:configureCell
                                                         cellIdentifierBlock:cellIdentifier
                                                             cellHeightBlock:heightBlock
                                                              didSelectBlock:selectBlock];
    
    [self.tableHandler HandleTableViewDataSourceAndDelegate:self.tableView];
    
}


@end
