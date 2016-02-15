
//
//  CircleIndex.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/15.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CircleIndex.h"

@interface CircleIndex ()
{
    TableViewDataSourceDelegate *tableHandler;
    
     NSDictionary* testTopicDic;
}

@property(nonatomic,strong) NSMutableArray *sectionItemsArray;

@end

@implementation CircleIndex

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testTopicDic = @{
                     @"title":@"新年上班，你做的第一件事是什么？",
                     @"topic_date":@"12月20日",
                     @"topic_image":@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",
                     @"join_count":@1180
                     };
    [self setUpTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray*)sectionItemsArray
{
    if (!_sectionItemsArray) {
        _sectionItemsArray = [NSMutableArray array];
        Topic *topic = [Topic mj_objectWithKeyValues:testTopicDic];
        NSArray* topicArray = [NSArray arrayWithObject:topic];
        TableViewSection* section0 = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:11.0f items:topicArray];
        [_sectionItemsArray addObject:section0];
    }
    return _sectionItemsArray;
}

-(void)setUpTableView
{
    self.tableView.tableFooterView                = [Config getTableViewFooter];
    
    TableViewCellConfigureCellBlock configureCell = ^(NSIndexPath* indexPath,id obj,UITableViewCell* cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    };
    
    CellIdentifierBlock cellIdentifier            = ^NSString*(NSIndexPath* indexPath,id item){
        return [TopicCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
    };
    
    CellHeightBlock heightBlock                   = ^CGFloat(NSIndexPath* indexPath,id item){
        return [self.tableView fd_heightForCellWithIdentifier:cellIdentifier(indexPath,item) cacheByIndexPath:indexPath configuration:^(id cell) {
            configureCell(indexPath,item,cell);
        }];
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
