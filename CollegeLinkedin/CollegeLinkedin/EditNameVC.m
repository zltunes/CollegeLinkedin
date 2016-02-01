//
//  EditNameVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/26.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "Config.h"
#import "EditNameVC.h"
#import "TextFieldValidator.h"

@interface EditNameVC (){
    IBOutlet TextFieldValidator *nameTextField;
}

@end

@implementation EditNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dic = [[Config getInfoPlistDict] objectForKey:@"RegularExpressions"];
    [nameTextField addRegx:[dic objectForKey:@"userNameRex"] withMsg:@"用户名必须为2-4个汉字"];
    nameTextField.validateOnResign = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    if ([nameTextField validate]){
        self.getNameBK(nameTextField.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [Config showErrorHUDwithStatus:@"用户名不符合规则!"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
