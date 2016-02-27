//
//  RegisterVC.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewModel.h"
#import "ZHPickView.h"

@interface RegisterVC : UIViewController<ZHPickViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField       *phoneTextFiled;

@property (strong, nonatomic) IBOutlet UITextField       *pwdTextField;

@property (strong, nonatomic) IBOutlet UITextField       *enroll_yearTextField;

@property (strong, nonatomic) IBOutlet UITextField       *schoolTextField;

@property (strong, nonatomic) IBOutlet UITextField       *majorTextField;

@property (strong, nonatomic) IBOutlet UIView            *enroll_yearView;

@property (strong, nonatomic) IBOutlet UIView            *schoolView;

@property (strong, nonatomic) IBOutlet UIView            *majorView;

@property (strong, nonatomic) IBOutlet UIButton          *RegisterBtn;

@property (nonatomic,strong ) RegisterViewModel *registerViewModel;


@end
