//
//  User.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "MJExtension.h"

@interface User : RLMObject

@property NSInteger user_id;
@property NSString  * access_token;
@property BOOL      isLogin;
@property NSString* phone_num;
@property NSString  *password;
@property NSString  *enroll_year;
@property NSString  *school;
@property NSString  *major;

@end

RLM_ARRAY_TYPE(User)