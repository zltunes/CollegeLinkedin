//
//  MeBaseInfoCellWithTwoLabels.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/25.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "MeBaseInfoCellWithTwoLabels.h"
#import "MeBaseInfoItem.h"

static NSString* const MeBaseInfoCellID1   = @"MeBaseInfoCellWithTwoLabels";
static const CGFloat MeBaseInfoCell1Height = 45.0f;

@implementation MeBaseInfoCellWithTwoLabels

//重写extension中cell绘制和行高设置的方法
-(void)configure:(UITableViewCell *)cell
       customObj:(id)obj
       indexPath:(NSIndexPath *)indexPath
{
    MeBaseInfoCellWithTwoLabels* infoCell = (MeBaseInfoCellWithTwoLabels*)cell;
    MeBaseInfoItem* item                  = (MeBaseInfoItem*)obj;
    infoCell.itemLabel.text               = item.title;
    infoCell.operationLabel.text          = item.content;
}

+(CGFloat)getCellHeightWithCustomObj:(id)obj
                           indexPath:(NSIndexPath *)indexPath
{
    return MeBaseInfoCell1Height;
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return MeBaseInfoCellID1;
}

@end
