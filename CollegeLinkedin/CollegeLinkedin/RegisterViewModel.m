//
//  RegisterViewModel.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/27.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

-(User*)user
{
    if(_user == nil){
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

-(void)initialBind
{
//    注册按钮是否可用
    self.enableRegisterSignal = [RACSignal combineLatest:@[RACObserve(self.user, phone_num),RACObserve(self.user, password),RACObserve(self.user, enroll_year),RACObserve(self.user, school),RACObserve(self.user, major)] reduce:^id(NSString *phone_num,NSString *password,NSString *enroll_year,NSString *school,NSString* major){
        
        NSPredicate *phoneNum_prdicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1[3|4|5|7|8][0-9]\\d{8}$"];
        NSPredicate *pwd_predicate     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^.{6,}$"];
        
//        &&
//
        if ([phoneNum_prdicate evaluateWithObject:phone_num] && [pwd_predicate evaluateWithObject:password] &&enroll_year.length>0 && school.length>0 && major.length>0) {
            
            NSLog(@"yes");
            return @(YES);
            
        }else{
            
            NSLog(@"no");
            return @(NO);
            
        }
        
//        return @(enroll_year.length && school.length && major.length && [phoneNum_prdicate evaluateWithObject:phone_num] && [pwd_predicate evaluateWithObject:password]);
    }];
    
    
//    注册事件
    self.registerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSLog(@"如果注册成功,command发出:");
            [subscriber sendNext:@"success!"];
            
//            ⚠️⚠️⚠️注意事件执行结束之后必须调用，否则永远在执行:
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
//    监听注册结果：
    [_registerCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        if ([result isEqualToString:@"success!"]) {
            NSLog(@"监听到注册成功!");
        }
    }];
    
//    监听注册事件执行,默认执行一次，跳过:
    [[_registerCommand.executing skip:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            [Config showProgressHUDwithStatus:@"注册中..."];
        } else {
            [Config dismissHUD];
        }
    }];
}



@end
