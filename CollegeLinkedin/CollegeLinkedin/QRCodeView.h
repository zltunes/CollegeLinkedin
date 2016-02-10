//
//  QRCodeView.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/9.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCustomViewFromXib.h"

@interface QRCodeView : PSCustomViewFromXib

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *placeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *QRCodeImg;


@end
