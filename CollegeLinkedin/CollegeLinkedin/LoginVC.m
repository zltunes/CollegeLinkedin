//
//  LoginVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "LoginVC.h"

@implementation LoginVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bindModel];
}

-(LoginViewModel*)loginViewModel
{
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}

//视图模型绑定
-(void)bindModel
{
//    给模型的属性绑定信号
//    账号文本框一改变，就给 User属性赋值
    
    NSLog(@"bind");
    RAC(self.loginViewModel.user,phone_num) = _accountTextField.rac_textSignal;
    RAC(self.loginViewModel.user,password)  = _pwdTextField.rac_textSignal;
//    为登录按钮的"enable"属性绑定信号
    RAC(self.loginBtn,enabled)              = self.loginViewModel.enableLoginSignal;
    
//    监听登录按钮的点击,执行loginCommand
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
//        执行登录
        [self.loginViewModel.loginCommand execute:nil];
        
    }];

}



@end
