//
//  MeBaseInfoCellWithPhoto.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/25.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "MeBaseInfoCellWithPhoto.h"

static const CGFloat MeBaseInfoCell0Height = 74.0f;

@implementation MeBaseInfoCellWithPhoto

//重写extension中cell绘制和行高设置的方法
-(void)configure:(UITableViewCell *)cell
       customObj:(id)obj
       indexPath:(NSIndexPath *)indexPath
{
    MeBaseInfoCellWithPhoto* photoCell = (MeBaseInfoCellWithPhoto*) cell;
    photoCell.photo.backgroundColor = [UIColor redColor];
}

+(CGFloat)getCellHeightWithCustomObj:(id)obj
                           indexPath:(NSIndexPath *)indexPath
{
    return MeBaseInfoCell0Height;
}


@end
