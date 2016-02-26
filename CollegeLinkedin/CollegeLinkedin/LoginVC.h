//
//  LoginVC.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Config.h"
#import "LoginViewModel.h"

@interface LoginVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField    *accountTextField;

@property (strong, nonatomic) IBOutlet UITextField    *pwdTextField;

@property (strong, nonatomic) IBOutlet UIButton       *loginBtn;

@property (strong, nonatomic) IBOutlet UIButton       *weixinLoginBtn;

@property (strong, nonatomic) IBOutlet UIButton       *RegisterBtn;

@property (strong,nonatomic ) LoginViewModel *loginViewModel;

@end
