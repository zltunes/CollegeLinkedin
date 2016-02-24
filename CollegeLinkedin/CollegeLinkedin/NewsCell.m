//
//  NewsCell.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/21.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "NewsCell.h"

static NSString* const cellId    = @"NewsCell";
static NSString* const imgCellId = @"NewsImageCell";
static const float CellMargin    = 10.0f;

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
    [self updateCollectionHeighrConstraint];
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

-(void)updateCollectionHeighrConstraint
{
    NSUInteger count = self.images.count;
    CGSize itemSize = [self sizeForItems];
    CGFloat itemH = itemSize.height;
    
    if (count==0) {
        self.collectionHeightConstraint.constant = 0;
    } else if(count>0 && count<4){
        self.collectionHeightConstraint.constant = itemH+CellMargin;
    } else if(count>3 && count<7){
        self.collectionHeightConstraint.constant = (itemH+CellMargin)*2;
    } else {
        self.collectionHeightConstraint.constant = (itemH+CellMargin)*3;
    }
}

-(CGSize)sizeForItems
{
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
    
    return CGSizeMake(itemW, itemH);
}

#pragma mark -- UICollectionDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    return [self sizeForItems];
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


//分享
- (IBAction)shareBtnClicked:(id)sender
{

    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    _activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:delegate.window.rootViewController.view];
    _activityView.numberOfButtonPerLine = 4;
    
    ButtonView *bv = [[ButtonView alloc]initWithText:@"校友圈动态" image:[UIImage imageNamed:@"校友圈"] handler:^(ButtonView *buttonView){

        
    }];
    [_activityView addButtonView:bv];
    
    bv = [[ButtonView alloc]initWithText:@"微信好友" image:[UIImage imageNamed:@"微信-1"] handler:^(ButtonView *buttonView){
        
    }];
    [_activityView addButtonView:bv];
    
    bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"微信朋友圈"] handler:^(ButtonView *buttonView){

    }];
    [_activityView addButtonView:bv];
    
    bv = [[ButtonView alloc]initWithText:@"QQ空间" image:[UIImage imageNamed:@"qq空间"] handler:^(ButtonView *buttonView){

    }];
    [_activityView addButtonView:bv];
    
    [_activityView show];
}




@end
