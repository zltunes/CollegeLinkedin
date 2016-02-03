//
//  leftCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "leftCell.h"

static NSString* const leftCellID = @"leftCell";

@implementation leftCell


-(void)configure:(UITableViewCell *)cell
       customObj:(id)obj
       indexPath:(NSIndexPath *)indexPath
{
    leftCell *industryCell = (leftCell*)cell;
    Industry *industry = (Industry*)obj;
    industryCell.label.text = industry.name;
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return leftCellID;
}

@end
