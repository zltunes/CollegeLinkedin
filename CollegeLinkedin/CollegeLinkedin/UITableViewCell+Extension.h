//
//  UITableViewCell+Extension.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/7.
//  Copyright © 2016年 赵磊. All rights reserved.
//
//  用category实现cell绘制和行高是为了避免向model暴露cell内部。
//  避免 model 和 view 的耦合。
//  写在Category里，比较灵活，可以提供多个configure方法，针对不同类型的Model进行数据展示，同时也增强Cell的移植性。

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

//实际是tableView reigister nib，由于是与cell(view)紧密相关的方法，故在cell本身进行实现，而非在vc中。
+(void) registerTable:(UITableView*)table
        nibIdentifier:(NSString*)identifier;

-(void)configure:(UITableViewCell*)cell
       customObj:(id)obj
       indexPath:(NSIndexPath*)indexPath;

+(CGFloat)getCellHeightWithCustomObj:(id)obj
                        indexPath:(NSIndexPath*)indexPath;

@end
