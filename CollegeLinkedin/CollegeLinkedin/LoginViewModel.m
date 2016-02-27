//
//  LoginViewModel.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "LoginViewModel.h"

//1⃣️：判断登录按钮是否可用。
//2⃣️：定义登录事件。

@implementation LoginViewModel

-(User*)user
{
    if (_user == nil) {
        _user = [[User alloc]init];
    }
    return _user;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

//初始化绑定
-(void)initialBind
{
//    监听账号的属性值改变，把它们聚合为一个信号。
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.user, phone_num),RACObserve(self.user, password)] reduce:^id(NSString *phone_num,NSString *password){

        NSPredicate *phoneNum_prdicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1[3|4|5|7|8][0-9]\\d{8}$"];
        NSPredicate *pwd_predicate     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^.{6,}$"];
        return @([phoneNum_prdicate evaluateWithObject:phone_num] && [pwd_predicate evaluateWithObject:password]);
        
    }];
    
//    处理登录的业务逻辑
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"点击登录按钮!");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"command signalBlock返回的信号发送success。");
            
            [subscriber sendNext:@"success!"];
            
//            数据传送完毕必须调用，否则永远处于执行状态。
            [subscriber sendCompleted];
            
            return nil;
            
        }];
    }];
    

    
//    监听登录状态
    [[_loginCommand.executing skip:1]subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            [Config showProgressHUDwithStatus:@"登录中..."];
        } else {
            [Config dismissHUD];
        }
    }];
    
}

@end
