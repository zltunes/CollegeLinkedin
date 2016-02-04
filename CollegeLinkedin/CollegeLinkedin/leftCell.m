//
//  leftCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/3.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "leftCell.h"
#import "Config.h"


static NSString* const leftCellID = @"leftCell";

@implementation leftCell

- (void)awakeFromNib {
    
    UIView *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    indicatorView.backgroundColor = [Config getTintColor];
    
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-5, self.frame.size.height)];
    otherView.backgroundColor = [UIColor colorWithRed:0.921 green:0.921 blue:0.921 alpha:1];
    
    [self.selectedBackgroundView addSubview:indicatorView];
    [self.selectedBackgroundView addSubview:otherView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


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
