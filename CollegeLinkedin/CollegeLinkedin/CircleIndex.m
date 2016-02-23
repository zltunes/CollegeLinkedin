
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
    
     NSDictionary *testTopicDic;
     NSArray* testNewsArr;
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
    
    NSDictionary* testNewsDic = @{
                    @"user_image":@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",
                    @"name":@"童小新",
                    @"user_job":@"播音主持",
                    @"enroll_year":@2013,
                    @"user_major":@"艺术学院",
                    @"post_time":@"18分钟前",
                    @"news_text":@"万能的朋友圈，我是2013级播音主持系毕业的！如果大家喜欢我，加我好友哦！附图一张!",
                    @"image":[NSArray arrayWithObjects:@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",@"http://ww2.sinaimg.cn/large/005tGCqhjw1f104ny4fl1j302o02f0sn.jpg",nil],
                    @"comment_amount":@999,
                    @"like_amount":@228,
                    @"share_amount":@12
                    };
    
    testNewsArr = [NSArray array];
    testNewsArr = [testNewsArr arrayByAddingObject:testNewsDic];
    
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
        
        for (NSDictionary* newsDict in testNewsArr) {
            News* news = [News mj_objectWithKeyValues:newsDict];
            NSArray *newsArray = [NSArray arrayWithObject:news];
            TableViewSection* newsSection = [[TableViewSection alloc]initWithHeaderTitle:nil headerHeight:11.0f items:newsArray];
            [_sectionItemsArray addObject:newsSection];
        }

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
        if (indexPath.section == 0) {
            return [TopicCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
        } else {
            return [NewsCell getCellIdentifierWithCustomObj:item indexPath:indexPath];
        }
    };
    
    CellHeightBlock heightBlock                   = ^CGFloat(NSIndexPath* indexPath,id item){
//        if (indexPath.section == 0) {
//            return [self.tableView fd_heightForCellWithIdentifier:cellIdentifier(indexPath,item) cacheByIndexPath:indexPath configuration:^(id cell) {
//                configureCell(indexPath,item,cell);
//            }];
//        } else {
//            return 450.0f;
//        }
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
