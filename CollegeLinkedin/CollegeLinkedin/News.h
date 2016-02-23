//
//  News.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/21.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic,assign) int      news_id;
@property (nonatomic,copy  ) NSString * post_time;
@property (nonatomic,assign) int      user_id;
@property (nonatomic,copy  ) NSString * user_image;
@property (nonatomic,copy  ) NSString * name;

//api暂无
@property (nonatomic,assign) int      enroll_year;
@property (nonatomic,copy  ) NSString * user_job;
@property (nonatomic,copy  ) NSString * user_major;

@property (nonatomic,copy  ) NSString * news_text;
@property (nonatomic,copy  ) NSArray  * image;
@property (nonatomic,assign) int      like_amount;
@property (nonatomic,assign) int      comment_amount;
@property (nonatomic,assign) int      share_amount;
@property (nonatomic,copy  ) NSString * news_type;
@property (nonatomic,assign) int      topic_id;
@property (nonatomic,assign) int      share_new_id;
@property (nonatomic,copy  ) NSString * share_news_text;

@property (nonatomic, assign          ) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end



