//
//  CelebrityCell.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/12.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "UIImageView+WebCache.h"

@interface CelebrityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *positionLabel;

@property (strong, nonatomic) IBOutlet UIButton *operationBtn;



@end
