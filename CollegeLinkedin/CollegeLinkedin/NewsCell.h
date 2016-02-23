//
//  NewsCell.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/21.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsImageCell.h"
#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"

@interface NewsCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>

@property (strong, nonatomic) IBOutlet UIImageView      *photo;

@property (strong, nonatomic) IBOutlet UILabel          *label_name;

@property (strong, nonatomic) IBOutlet UILabel          *label_industry;

@property (strong, nonatomic) IBOutlet UILabel          *label_time;

@property (strong, nonatomic) IBOutlet UILabel          *label_education;

@property (strong, nonatomic) IBOutlet UILabel          *label_newsText;

@property (strong, nonatomic) IBOutlet UIButton         *moreButton;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIButton *btn_comment;

@property (strong, nonatomic) IBOutlet UIButton *btn_like;

@property (strong, nonatomic) IBOutlet UIButton *btn_share;


@property (nonatomic,assign ) BOOL             shouldOpenContentLabel;

@property (nonatomic,strong) NSArray *images;

@end
