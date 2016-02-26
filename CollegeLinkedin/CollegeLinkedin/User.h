//
//  User.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,copy) NSString *phone_num;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *enroll_year;
@property(nonatomic,copy) NSString *school;
@property(nonatomic,copy) NSString *major;

@end
