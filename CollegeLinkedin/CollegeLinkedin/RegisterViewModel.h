//
//  RegisterViewModel.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/27.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Config.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegisterViewModel : NSObject

@property (nonatomic,strong) User       *user;
//注册按钮是否可用:
@property (nonatomic,strong) RACSignal  *enableRegisterSignal;
//注册事件:
@property (nonatomic,strong) RACCommand *registerCommand;



@end
