//
//  EditCompanyNameVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 2016-01-31.
//  Copyright © 2016 赵磊. All rights reserved.
//

#import "EditCompanyNameVC.h"
#import "TextFieldValidator.h"
#import "Config.h"

@interface EditCompanyNameVC (){
    IBOutlet TextFieldValidator *companyNameTextField;
}

@end

@implementation EditCompanyNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = [[Config getInfoPlistDict] objectForKey:@"RegularExpressions"];
    [companyNameTextField addRegx:[dict objectForKey:@"companyNameRex"] withMsg:@"公司名称应不超过20字"];
    companyNameTextField.validateOnResign = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    if ([companyNameTextField validate]) {
        self.getCompanyNameBK(companyNameTextField.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [Config showErrorHUDwithStatus:@"公司名称不符合规则!"];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
