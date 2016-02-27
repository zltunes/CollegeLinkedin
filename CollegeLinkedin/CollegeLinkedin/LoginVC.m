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
    
    RAC(self.loginViewModel.user,phone_num) = _accountTextField.rac_textSignal;
    RAC(self.loginViewModel.user,password)  = _pwdTextField.rac_textSignal;
    
//    为登录按钮的"enable"属性绑定信号
    RAC(self.loginBtn,enabled)              = self.loginViewModel.enableLoginSignal;
    
//    监听登录按钮的点击,执行loginCommand
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
//        执行登录
        [self.loginViewModel.loginCommand execute:nil];
        
    }];
    
    //    监听登录产生的数据
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        if ([x isEqualToString:@"success!"]) {
            NSLog(@"监听到登录成功！");
            [self performSegueWithIdentifier:@"toTabBarController" sender:nil];
        }
    }];

}



@end
