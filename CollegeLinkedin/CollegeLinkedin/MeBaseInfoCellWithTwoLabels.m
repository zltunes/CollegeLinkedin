//
//  MeBaseInfoCellWithTwoLabels.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/25.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "MeBaseInfoCellWithTwoLabels.h"

static const CGFloat MeBaseInfoCell1Height = 45.0f;

@implementation MeBaseInfoCellWithTwoLabels

//重写extension中cell绘制和行高设置的方法
-(void)configure:(UITableViewCell *)cell
       customObj:(id)obj
       indexPath:(NSIndexPath *)indexPath
{
    MeBaseInfoCellWithTwoLabels* infoCell = (MeBaseInfoCellWithTwoLabels*)cell;
    NSArray* infoObj = (NSArray*)obj;
    infoCell.itemLabel.text = (NSString*)infoObj[0];
    infoCell.operationLabel.text = (NSString*)infoObj[1];
}

+(CGFloat)getCellHeightWithCustomObj:(id)obj
                           indexPath:(NSIndexPath *)indexPath
{
    return MeBaseInfoCell1Height;
}

@end
