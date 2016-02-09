//
//  rightCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "rightCell.h"
#import "Config.h"

static NSString* const rightCellID = @"rightCell";

@implementation rightCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state

}

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

@end
