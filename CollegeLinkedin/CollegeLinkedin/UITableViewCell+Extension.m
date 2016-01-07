//
//  UITableViewCell+Extension.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/7.
//  Copyright © 2016年 赵磊. All rights reserved.
//
// 为了避开model和view的耦合. 使用category来做类的扩展

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

//获取cell对应nib
+(UINib*)nibWithIdentifier:(NSString*)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma - Public
+(void)registerTable:(UITableView *)table nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier] forCellReuseIdentifier:identifier];
}

#pragma --
#pragma Rewrite following fucs in SubClass!
//cell的绘制是与cell种类相关的，故此方法在Cell子类中实现 －－ 为了实现cell的复用
-(void)configure:(UITableViewCell *)cell customObj:(id)obj indexPath:(NSIndexPath *)indexPath
{
    //Rewrite in SubClass!
    //灵活提供多个configure方法，针对不同类型的Model进行数据展示，同时也增强Cell的移植性。
}

+(CGFloat)getCellHeightWithCustomObj:(id)obj indexPath:(NSIndexPath *)indexPath
{ 
    //Rewrite in SubClass if necessary!
    if(!obj){
        return 0.0f;
    }else{
        return 44.0f;
    }
    
}

@end
