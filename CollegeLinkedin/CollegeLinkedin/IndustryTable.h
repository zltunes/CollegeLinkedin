//
//  IndustryTable.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "leftCell.h"
#import "Industry.h"
#import "TableViewSection.h"
#import "TableViewDataSourceDelegate.h"
#import "MJExtension.h"
#import "UITableViewCell+Extension.h"

@protocol IndustryTableDelegate <NSObject>

-(void)didSelectCellWithIndustry:(Industry*)selectedIndustry;

@end


@interface IndustryTable : UITableViewController

@property(strong,nonatomic) Industry* selectedIndustry;
@property(weak,nonatomic) id<IndustryTableDelegate> delegate;
@property(strong,nonatomic) TableViewDataSourceDelegate* tableHandler;

@end
