//
//  Topic.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/15.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface Topic : NSObject

@property (nonatomic,assign) NSInteger topic_id;
@property (nonatomic,copy  ) NSString  * title;
@property (nonatomic,copy  ) NSString  * topic_text;
@property (nonatomic,copy  ) NSString  * topic_date;
@property (nonatomic,copy  ) NSString  * topic_image;
@property (nonatomic,assign) NSInteger join_count;

@end
