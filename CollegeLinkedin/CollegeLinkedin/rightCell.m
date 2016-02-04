//
//  rightCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "rightCell.h"

static NSString* const rightCellID = @"rightCell";

@implementation rightCell

-(void)configure:(UITableViewCell *)cell
       customObj:(id)obj
       indexPath:(NSIndexPath *)indexPath
{
    rightCell* careerCell = (rightCell*)cell;
    Career* career = (Career*)obj;
    careerCell.label.text = career.name;
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return rightCellID;
}

-(void)didSelectCell:(UITableViewCell*)cell
       WithCustomObj:(id)obj
           indexPath:(NSIndexPath*)indexPath
{
    rightCell *careerCell = (rightCell*)cell;
    [careerCell.indicatorView setBackgroundColor:[Config getTintColor]];
}

-(void)didDeselectCell:(UITableViewCell*)cell
         withCustomObj:(id)obj
             indexPath:(NSIndexPath*)indexPath
{
    rightCell *careerCell = (rightCell*)cell;
    [careerCell.indicatorView setBackgroundColor:[UIColor clearColor]];
}

@end
