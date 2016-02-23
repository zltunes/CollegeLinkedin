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
    NSLog(@"cellfor");
    NewsImageCell* cell = (NewsImageCell*)[self.collectionView dequeueReusableCellWithReuseIdentifier:imgCellId forIndexPath:indexPath];
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"Login_logo"]];
    [cell.imgView setImage:[UIImage imageNamed:@"Login_logo"]];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = [self itemWidthForImgArray:self.images];
    CGFloat itemH = 0;
    
    if(self.images.count == 1){
        UIImage *image = [UIImage imageNamed:self.images.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else{
        itemH = itemW;
    }
    
    return CGSizeMake(itemW, itemH);
}

- (CGFloat)itemWidthForImgArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}

//- (NSInteger)perRowItemCountForImgArray:(NSArray *)array
//{
//    if (array.count < 3) {
//        return array.count;
//    } else if (array.count <= 4) {
//        return 2;
//    } else {
//        return 3;
//    }
//}

// 设置每个 Cell 的上下边距 LineSpacing
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

//   设置每个 Cell 的左右边距,Interitem
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}



@end
