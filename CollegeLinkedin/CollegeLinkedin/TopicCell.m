//
//  TopicCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/15.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "TopicCell.h"

static NSString* const cellId = @"TopicCell";

@implementation TopicCell

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
    TopicCell *topicCell = (TopicCell*)cell;
    Topic *topic = (Topic*)obj;
    [topicCell.imgView sd_setImageWithURL:[NSURL URLWithString:topic.topic_image] placeholderImage:[UIImage imageNamed:@"我的二维码"]];
    topicCell.label_title.text = [NSString stringWithFormat:@"#%@#",topic.title];
    topicCell.label_time.text = topic.topic_date;
    topicCell.label_count.text = [NSString stringWithFormat:@"%ld人参加",(long)topic.join_count];
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return cellId;
}

@end
