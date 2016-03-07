//
//  RegisterVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/26.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "RegisterVC.h"

@implementation RegisterVC

{
    ZHPickView *pickerView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initPickView];
    
    [self bindModel];
    
}

-(RegisterViewModel*)registerViewModel
{
    if (_registerViewModel == nil) {
        _registerViewModel = [[RegisterViewModel alloc]init];
    }
    return _registerViewModel;
}

-(void)bindModel
{
//    为model属性绑定信号
    RAC(self.registerViewModel.user,phone_num)   = self.phoneTextFiled.rac_textSignal;
    RAC(self.registerViewModel.user,password)    = self.pwdTextField.rac_textSignal;
//    为registerBtn的enable属性绑定信号
    RAC(self.RegisterBtn,enabled)                = self.registerViewModel.enableRegisterSignal;
    
//    执行registerBtn点击事件
    [[self.RegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        [self.registerViewModel.registerCommand execute:nil];
    }];
    
    //    监听注册结果：
    [_registerViewModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        if ([result isEqualToString:@"success"]) {
            [Config showSuccessHUDwithStatus:@"注册成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Config showErrorHUDwithStatus:[NSString stringWithFormat:@"注册失败!%@",result]];
        }
    }];
    

}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initPickView
{
    
    NSArray *yearArray = @[@"2010",@"2011",@"2012",@"2013",@"2014",@"2015"];
    NSArray *schoolArray = @[@"软件学院",@"计算机学院",@"数学系",@"建筑学院",@"机械学院",@"土木学院"];
    NSArray *majorArray = @[@"计算机科学",@"软件工程",@"土木工程",@"建筑",@"医学",@"机械"];
    
    [[self rac_signalForSelector:@selector(toobarDonBtnHaveClick:resultString:)fromProtocol:@protocol(ZHPickViewDelegate)]subscribeNext:^(RACTuple *tuple) {
        
        if (((ZHPickView*)tuple.first).tag == 0) {
            [self.enroll_yearTextField setText:(NSString*)tuple.last];
            self.registerViewModel.user.enroll_year = tuple.last;
        } else if (((ZHPickView*)tuple.first).tag == 1){
            [self.schoolTextField setText:(NSString*)tuple.last];
            self.registerViewModel.user.school = tuple.last;
        } else {
            [self.majorTextField setText:(NSString*)tuple.last];
            self.registerViewModel.user.major = tuple.last;
        }
    }];
    
    UITapGestureRecognizer * tap_year = [[UITapGestureRecognizer alloc]init];
    [[tap_year rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        
        [self.phoneTextFiled resignFirstResponder];
        [self.pwdTextField resignFirstResponder];
        pickerView = [[ZHPickView alloc]initPickviewWithArray:yearArray isHaveNavControler:NO];
        pickerView.tag = 0;
        pickerView.delegate = self;
        [pickerView show];
    }];
    [self.enroll_yearView addGestureRecognizer:tap_year];
    
    UITapGestureRecognizer * tap_school = [[UITapGestureRecognizer alloc]init];
    [[tap_school rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        [self.phoneTextFiled resignFirstResponder];
        [self.pwdTextField resignFirstResponder];
        pickerView = [[ZHPickView alloc]initPickviewWithArray:schoolArray isHaveNavControler:NO];
        pickerView.tag = 1;
        pickerView.delegate = self;
        [pickerView show];
    }];
    [self.schoolView addGestureRecognizer:tap_school];
    
    UITapGestureRecognizer * tap_major = [[UITapGestureRecognizer alloc]init];
    
    [[tap_major rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        [self.phoneTextFiled resignFirstResponder];
        [self.pwdTextField resignFirstResponder];
        pickerView = [[ZHPickView alloc]initPickviewWithArray:majorArray isHaveNavControler:NO];
        pickerView.tag = 2;
        pickerView.delegate = self;
        [pickerView show];
    }];
    [self.majorView addGestureRecognizer:tap_major];

}


@end
