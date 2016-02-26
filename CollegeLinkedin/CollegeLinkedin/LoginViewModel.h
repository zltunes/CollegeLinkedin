//
//  LoginViewModel.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Config.h"

@interface LoginViewModel : NSObject

@property(nonatomic,strong) User *user;

//是否允许登录的信号
@property(nonatomic,strong,readonly) RACSignal *enableLoginSignal;
//执行登录操作的信号
@property(nonatomic,strong,readonly) RACCommand *loginCommand;

@end
