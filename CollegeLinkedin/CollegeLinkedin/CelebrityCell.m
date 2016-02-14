//
//  CelebrityCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/12.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CelebrityCell.h"

static const CGFloat cellHeight = 72.0f;
static NSString*  const cellID = @"CelebrityCell";

@implementation CelebrityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configure:(UITableViewCell*)cell
       customObj:(id)obj
       indexPath:(NSIndexPath*)indexPath
{
    CelebrityCell* celebrityCell = (CelebrityCell*)cell;
    Contact* celebrity = (Contact*)obj;
    
    [celebrityCell.photo sd_setImageWithURL:[NSURL URLWithString:celebrity.photo] placeholderImage:[UIImage imageNamed:@"我默认"]];
    celebrityCell.nameLabel.text = celebrity.name;
    celebrityCell.positionLabel.text = celebrity.job;
}

+(CGFloat)getCellHeightWithCustomObj:(id)obj
                           indexPath:(NSIndexPath*)indexPath
{
    return cellHeight;
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return cellID;
}

@end
