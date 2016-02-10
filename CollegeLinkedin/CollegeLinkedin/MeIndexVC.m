//
//  MeIndexVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/24.
//  Copyright © 2015年 赵磊. All rights reserved.
//


#import "MeIndexVC.h"
#import "MeCellWithPhoto.h"
#import "MeCellWithIcon.h"
#import "Config.h"
#import "CustomIOSAlertView.h"
#import "QRCodeView.h"
#import "FXBlurView.h"

static NSString* const MeCellID0         = @"MeCellWithPhoto";
static const CGFloat MeCell0Height       = 80.0f;
static NSString* const MeCellID1         = @"MeCellWithIcon";
static const CGFloat MeCell1Height       = 44.0f;
static const CGFloat sectionHeaderHeight = 11.0f;

@interface MeIndexVC ()

{
    CustomIOSAlertView *QRCodeAlertView;
    QRCodeView *qrcodeView;
    FXBlurView *blurView;
    
}

@property(strong,nonatomic) NSArray *cellItemArray;

@end

@implementation MeIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cellItemArray          = [[Config getInfoPlistDict] objectForKey:@"MeVCCellItems"];
    
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
    blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blurView setTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
        case 3:
            return 1;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return 3;
            break;
            
        default:
            return 1;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MeCellWithPhoto *cell      = (MeCellWithPhoto*)[tableView dequeueReusableCellWithIdentifier:MeCellID0];
        cell.photo.image = [UIImage imageNamed:@"账号"];
        cell.nameLabel.text        = @"童小星";
        return cell;
    } else {
        MeCellWithIcon *cell = (MeCellWithIcon*)[tableView dequeueReusableCellWithIdentifier:MeCellID1];
        switch (indexPath.section) {
            case 1:
                cell.label.text = self.cellItemArray[indexPath.row];
                cell.icon.image = [UIImage imageNamed:self.cellItemArray[indexPath.row]];
                break;
                
            case 2:
                cell.label.text = self.cellItemArray[indexPath.row+2];
                cell.icon.image = [UIImage imageNamed:self.cellItemArray[indexPath.row+2]];
                break;
                
            case 3:
                cell.label.text = self.cellItemArray[indexPath.row+5];
                cell.icon.image = [UIImage imageNamed:self.cellItemArray[indexPath.row+5]];
                break;
                
            default:
                break;
        }
        return cell;
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return MeCell0Height;
            break;
            
        default:
            return MeCell1Height;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeaderHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.section) {
//        头像
        case 0:
            
            break;
            
        case 1:
            if (indexPath.row == 0) {
//                编辑资料
                [self performSegueWithIdentifier:@"toMeBaseInfo" sender:nil];
            } else {
//                我的二维码
                QRCodeAlertView = [[CustomIOSAlertView alloc]init];
                [QRCodeAlertView setButtonTitles:nil];
                qrcodeView = [[QRCodeView alloc]initWithFrame:CGRectMake(0, 0, 328, 438)];
                [qrcodeView setBackgroundColor:[UIColor whiteColor]];
                [QRCodeAlertView setContainerView:qrcodeView];
                [QRCodeAlertView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertClose)]];
                [self.view addSubview:blurView];
                [UIView animateWithDuration:0.5 animations:^{
                        blurView.blurRadius = 25;
                }];
                
                [QRCodeAlertView show];
                
            }
            break;
        
        case 2:
            switch (indexPath.row) {
                case 0:
//                    我的动态
                    
                    break;
                    
                case 1:
//                    我的信息
                    
                    break;
                    
                case 2:
//                    我的收藏
                    
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 3:
//            设置
            [self performSegueWithIdentifier:@"toSettingVC" sender:nil];
            break;
            
        default:
            break;
    }
}

-(void)alertClose
{
    [QRCodeAlertView close];
    [blurView removeFromSuperview];
}

@end
