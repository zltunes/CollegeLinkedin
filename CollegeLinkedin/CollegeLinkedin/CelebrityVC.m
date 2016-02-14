//
//  CelebrityVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/12.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CelebrityVC.h"

@interface CelebrityVC ()
{
    TableViewDataSourceDelegate *tableHandler;
    
    NSMutableArray* testArray;
}

@property(nonatomic,copy)NSMutableArray *sectionItemsArray;

@end

@implementation CelebrityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testArray = (NSMutableArray*)@[
                  @{@"user_id":@0,
                    @"user_name":@"赵磊1",
                    @"image":@"http://ww4.sinaimg.cn/large/005tGCqhjw1f0xy036w60j3030030t8l.jpg",
                    @"user_job":@"东南大学学生",
                    @"user_school":@"东南大学",
                    },
                  @{@"user_id":@1,
                    @"user_name":@"赵磊2",
                    @"image":@"http://ww4.sinaimg.cn/large/005tGCqhjw1f0xy036w60j3030030t8l.jpg",
                    @"user_job":@"南京大学学生",
                    @"user_school":@"南京大学",
                    }
                  ];
    [self setUpTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray*)sectionItemsArray
{
    if (!_sectionItemsArray) {
        _sectionItemsArray = [NSMutableArray array];
        NSMutableArray* celebrities = [Contact mj_objectArrayWithKeyValuesArray:testArray];
        TableViewSection* section = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:11.0f items:celebrities];
        [_sectionItemsArray addObject:section];
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
        return [CelebrityCell getCellHeightWithCustomObj:item indexPath:indexPath];
    };
    
    CellIdentifierBlock cellIdentifier            = ^NSString*(NSIndexPath* indexPath,id item){
        return [CelebrityCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
    };
    
    DidSelectCellBlock selectBlock                = ^(NSIndexPath* indexPath,id item,UITableViewCell* cell){
        
    };
    
    tableHandler = [[TableViewDataSourceDelegate alloc]initWithSections:[self sectionItemsArray]
                                                     configureCellBlock:configureCell
                                                    cellIdentifierBlock:cellIdentifier
                                                        cellHeightBlock:heightBlock
                                                         didSelectBlock:selectBlock];
    
    [tableHandler HandleTableViewDataSourceAndDelegate:self.tableView];
}

@end
