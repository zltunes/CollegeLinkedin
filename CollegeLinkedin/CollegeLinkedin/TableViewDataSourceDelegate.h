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

//cellIdentifier
typedef NSString* (^CellIdentifierBlock)(NSIndexPath* indexPath,id item);

//点击事件
typedef void (^DidSelectCellBlock)(NSIndexPath* indexPath,id item,UITableViewCell* cell);

//deselect事件
typedef void (^DidDeselectCellBlock)(NSIndexPath* indexPath,id item,UITableViewCell* cell);

@interface TableViewDataSourceDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

//tableView初始化
-(id)initWithSections:(NSArray *)sections
   configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
  cellIdentifierBlock:(CellIdentifierBlock)identifierBlock
      cellHeightBlock:(CellHeightBlock)aHeightBlock
       didSelectBlock:(DidSelectCellBlock)aDidSelectBlock;

//tableview初始化（加入cell didDeselect 事件）
-(id)initWithSections:(NSArray *)sections
   configureCellBlock:(TableViewCellConfigureCellBlock)aConfigureCellBlock
  cellIdentifierBlock:(CellIdentifierBlock)identifierBlock
      cellHeightBlock:(CellHeightBlock)aHeightBlock
       didSelectBlock:(DidSelectCellBlock)aDidSelectBlock
     didDeselectBlcok:(DidDeselectCellBlock)aDidDeselectBlock;

//设置vc中的tableview delegate/dataSource 均为本类
-(void) HandleTableViewDataSourceAndDelegate:(UITableView* )table;

//获取某一item
-(id) itemAtIndexPath:(NSIndexPath* )indexPath;

@end
