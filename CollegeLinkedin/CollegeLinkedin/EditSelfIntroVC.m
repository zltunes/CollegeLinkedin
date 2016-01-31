
//
//  EditSelfIntroVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 2016-01-31.
//  Copyright © 2016 赵磊. All rights reserved.
//

#import "EditSelfIntroVC.h"
#import "Config.h"

@interface EditSelfIntroVC ()
{
    IBOutlet UITextView *textView;
}
@end

@implementation EditSelfIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.≠≠≠
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    NSString *info = textView.text;
    if (info.length==0 || [info isEqualToString:@"个人简介应不超过三十字"]) {
        [Config showErrorHUDwithStatus:@"输入不可为空!"];
    } else if(info.length>30){
        [Config showErrorHUDwithStatus:@"个人简介应不超过30字!"];
    } else{
        self.getSelfInfoBK(textView.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"个人简介应不超过三十字"]) {
        [textView setText:@""];
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
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
