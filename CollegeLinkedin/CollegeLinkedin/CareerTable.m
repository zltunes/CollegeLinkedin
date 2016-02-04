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
@property (nonatomic,strong) TableViewDataSourceDelegate * tableHandler;

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
    if (!_sectionItemsArray) {
//        初始选择
        _sectionItemsArray = [NSArray array];
        _careersArray = [NSArray array];
        
        
        
    }
    return _sectionItemsArray;
}

-(void)setUpTableView
{
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
}


#pragma mark IndustryTableDelegate

-(void)didSelectCellWithIndustry:(Industry *)selectedIndustry
{
    
}

@end
