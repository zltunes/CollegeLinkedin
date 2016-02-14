//
//  NewFriendCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/12.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "NewFriendCell.h"

static NSString* const cellID   = @"NewFriendCell";
static const CGFloat cellHeight = 85.0f;

@implementation NewFriendCell

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
    NewFriendCell* friendCell = (NewFriendCell*)cell;
    RequestedContact* requestContact = (RequestedContact*)obj;
    
    [friendCell.photo sd_setImageWithURL:[NSURL URLWithString:requestContact.photo] placeholderImage:[UIImage imageNamed:@"我默认"]];
    friendCell.nameLabel.text = requestContact.name;
    friendCell.positionLabel.text = requestContact.job;
    friendCell.infoLabel.text = requestContact.add_friend_text;
    
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
