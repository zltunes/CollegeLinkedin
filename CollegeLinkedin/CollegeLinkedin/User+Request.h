//
//  User+Request.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/3/1.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "User.h"
#import "Config.h"
#import "AFHTTPRequestOperationManager.h"

@interface User (Request)

//注册
+(void)registerWithParameters:(NSDictionary*)param SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;
//登录
+(void)loginWithParameters:(NSDictionary*)param SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

@end
