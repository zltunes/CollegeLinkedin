//
//  TwoSelectorsVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/2.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "TwoSelectorsVC.h"

@interface TwoSelectorsVC ()

@property(strong,nonatomic) NSArray* leftSectionItemsArray;
@property(strong,nonatomic) NSArray* rightSectionItemsArray;
@property(strong,nonatomic) TableViewDataSourceDelegate* leftTableHandler;
@property(strong,nonatomic) TableViewDataSourceDelegate* rightTableHandler;

@end

@implementation TwoSelectorsVC

-(NSArray*) leftSectionItemsArray
{
    if (!_leftSectionItemsArray) {
        
        _leftSectionItemsArray = [NSArray array];
        NSArray *cellArray = [NSArray array];
        cellArray = [Industry mj_objectArrayWithKeyValuesArray:[Config getIndustryArray]];
        TableViewSection* section = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:0 items:cellArray];
        _leftSectionItemsArray = [_leftSectionItemsArray arrayByAddingObject:section];
    
    };
    
    return _leftSectionItemsArray;
}

-(NSArray*) rightSectionItemsArray
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
