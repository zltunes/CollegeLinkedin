//
//  User+Request.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/3/1.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "User+Request.h"

@implementation User (Request)

+(void)registerWithParameters:(NSDictionary*)param SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSString* registerURL = [NSString stringWithFormat:@"%@/user/",[Config getMainURL]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    [manager POST:registerURL parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        successBlock(responseObject);
    
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}

+(void)loginWithParameters:(NSDictionary*)param SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSString* loginURL = [NSString stringWithFormat:@"%@/auth/login/",[Config getMainURL]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:loginURL parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];
}

@end
