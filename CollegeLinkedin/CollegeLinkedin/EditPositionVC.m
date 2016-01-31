//
//  EditPositionVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 2016-01-31.
//  Copyright © 2016 赵磊. All rights reserved.
//

#import "EditPositionVC.h"
#import "Config.h"
#import "TextFieldValidator.h"

@interface EditPositionVC ()
{
    IBOutlet TextFieldValidator *positionTextField;
}
@end

@implementation EditPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary* dict = [[Config getInfoPlistDict] objectForKey:@"RegularExpressions"];
    [positionTextField addRegx:[dict objectForKey:@"positionNameRex"] withMsg:@"职位名称应不超过20字"];
    positionTextField.validateOnResign = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    if ([positionTextField validate]) {
        self.getPositionBK(positionTextField.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [Config showErrorHUDwithStatus:@"职位名称不符合规则!"];
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
