//
//  TwoSelectorsVC.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/2.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "leftCell.h"
#import "rightCell.h"
#import "TableViewSection.h"
#import "TableViewDataSourceDelegate.h"
#import "MJExtension.h"


@interface TwoSelectorsVC : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *leftTable;

@property (strong, nonatomic) IBOutlet UITableView *rightTable;


@end
