//
//  NewsCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/21.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "NewsCell.h"

static NSString* const cellId = @"NewsCell";
static NSString* const imgCellId = @"NewsImageCell";

@implementation NewsCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configure:(UITableViewCell*)cell
       customObj:(id)obj
       indexPath:(NSIndexPath*)indexPath
{
    News* news = (News*)obj;
    NewsCell* newsCell = (NewsCell*)cell;
    
    [newsCell.photo sd_setImageWithURL:[NSURL URLWithString:news.user_image] placeholderImage:[UIImage imageNamed:@"Login_logo"]];
    newsCell.label_name.text = news.name;
    newsCell.label_industry.text = news.user_job;
    newsCell.label_education.text = [NSString stringWithFormat:@"%d届%@",news.enroll_year,news.user_major];
    newsCell.label_time.text = news.post_time;
    newsCell.label_newsText.text = news.news_text;
    
    newsCell.images = news.image;
    [self.collectionView reloadData];
    
    [newsCell.btn_comment setTitle:[NSString stringWithFormat:@"%d",news.comment_amount] forState:UIControlStateNormal];
    [newsCell.btn_like setTitle:[NSString stringWithFormat:@"%d",news.like_amount] forState:UIControlStateNormal];
    [newsCell.btn_share setTitle:[NSString stringWithFormat:@"%d",news.share_amount] forState:UIControlStateNormal];
}

+(NSString*)getCellIdentifierWithCustomObj:(id)obj
                                 indexPath:(NSIndexPath*)indexPath
{
    return cellId;
}

#pragma mark -- UICollectionDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"照片数：%lu",(unsigned long)self.images.count);
    return self.images.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsImageCell* cell = (NewsImageCell*)[self.collectionView dequeueReusableCellWithReuseIdentifier:imgCellId forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"Login_logo"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    cell.imgView.userInteractionEnabled = YES;
    cell.imgView.tag = indexPath.row;
    [cell.imgView addGestureRecognizer:tap];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sizefor");
    
    CGFloat itemW = [self itemWidthForImgArray:self.images];
    CGFloat itemH = 0;
    
    if(self.images.count == 1){
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.images.firstObject]]];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else{
        itemH = itemW;
    }
    
    if (indexPath.row == self.images.count-1) {
//        改写collectionView高度约束
        if (self.images.count == 0) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[collectionView(%d)]",0 ]
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(collectionView)]];
        } else if(self.images.count>0 && self.images.count<4){
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[collectionView(%g)]",itemH ]
                                                                options:0
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(collectionView)]];
        } else if(self.images.count>3 && self.images.count<7){
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[collectionView(%g)]",itemH *2]
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(collectionView)]];
        } else{
            [self.collectionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[collectionView(%g)]",itemH *3]
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(collectionView)]];
        }
    }
    
    
    
    

    return CGSizeMake(itemW, itemH);
}

- (CGFloat)itemWidthForImgArray:(NSArray *)array
{
    if (array.count == 1) {
        return 170;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 100 : 90;
        return w;
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.collectionView;
    browser.imageCount = self.images.count;
    browser.delegate = self;
    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.images[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    NewsImageCell* cell = (NewsImageCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    UIImageView *imageView = cell.imgView;
    return imageView.image;
}




@end
