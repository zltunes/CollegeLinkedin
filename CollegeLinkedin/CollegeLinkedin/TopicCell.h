//
//  TopicCell.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/15.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface TopicCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *label_title;

@property (strong, nonatomic) IBOutlet UILabel *label_time;

@property (strong, nonatomic) IBOutlet UILabel *label_count;


@end
