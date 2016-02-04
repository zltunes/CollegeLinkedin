//
//  CareerTable.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "rightCell.h"
#import "Industry.h"
#import "Career.h"
#import "TableViewSection.h"
#import "TableViewDataSourceDelegate.h"
#import "MJExtension.h"
#import "UITableViewCell+Extension.h"
#import "IndustryTable.h"

@protocol CareerTableDelegate <NSObject>

-(void)didSelectCellWithCareer:(Career*)career;

@end


@interface CareerTable : UITableViewController<IndustryTableDelegate>

@property(nonatomic,strong) Career* selectedCareer;
@property(nonatomic,strong) id<CareerTableDelegate> delegate;

@end
