//
//  TableViewDataSourceDelegate.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/7.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//cell配置,item -> model; cell -> view
typedef void (^TableViewCellConfigureCellBlock)(NSIndexPath* indexPath,id item,UITableViewCell* cell);

//cell行高,height可以存在item中
typedef CGFloat (^CellHeightBlock)(NSIndexPath* indexPath,id item);

//点击事件
typedef void (^DidSelectCellBlock)(NSIndexPath* indexPath,id item);

@interface TableViewDataSourceDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

//tableView初始化
-(id)initWithItems:(NSArray* )anItems
    cellIdentifier:(NSString* )aCellIdentifier
configureCellBlock:(TableViewCellConfigureCellBlock )aConfigureCellBlock
   cellHeightBlock:(CellHeightBlock )aHeightBlock
    didSelectBlock:(DidSelectCellBlock )aDidSelectBlock;

//设置vc中的tableview delegate/dataSource 均为本类
-(void) HandleTableViewDataSourceAndDelegate:(UITableView* )table;

//获取某一item
-(id) itemAtIndexPath:(NSIndexPath* )indexPath;

@end
