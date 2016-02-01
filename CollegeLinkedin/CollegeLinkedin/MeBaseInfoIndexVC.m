//
//  MeBaseInfoIndexVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/25.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "MeBaseInfoIndexVC.h"
#import "Config.h"
#import "MeBaseInfoCellWithPhoto.h"
#import "MeBaseInfoCellWithTwoLabels.h"
#import "EditNameVC.h"
#import "EditCompanyNameVC.h"
#import "EditSelfIntroVC.h"
#import "TableViewDataSourceDelegate.h"
#import "UITableViewCell+Extension.h"
#import "MeBaseInfoItem.h"
#import "MeBaseInfoPhotoItem.h"
#import "TableViewSection.h"
#import "ZHPickView.h"
#import "EditPositionVC.h"

@interface MeBaseInfoIndexVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,ZHPickViewDelegate>

@property(strong,nonatomic) NSArray* sectionItemsArray;
@property(strong,nonatomic) TableViewDataSourceDelegate* tableHandler;
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation MeBaseInfoIndexVC

-(NSArray*) sectionItemsArray
{
    if(!_sectionItemsArray){
        _sectionItemsArray = [NSArray array];
        
        NSArray* cellArray = [NSArray array];

        MeBaseInfoPhotoItem* item0 = [[MeBaseInfoPhotoItem alloc]initWithTitle:@"头像" andPhoto:[UIImage imageNamed:@"账号"]];
        cellArray = [cellArray arrayByAddingObject:item0];

        NSArray* cellItemsArray = [[Config getInfoPlistDict] objectForKey:@"MeBaseInfoCellItems"];
        for (NSArray* array in cellItemsArray) {
            MeBaseInfoItem* item = [[MeBaseInfoItem alloc]initWithTitle:array[0] andContent:array[1]];
            cellArray = [cellArray arrayByAddingObject:item];
        }
        
        TableViewSection *section = [[TableViewSection alloc]initWithHeaderTitle:@"" headerHeight:11.0f items:cellArray];
        
        _sectionItemsArray = [_sectionItemsArray arrayByAddingObject:section];
    }
    
    return _sectionItemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)setupTableView{
    
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
    TableViewCellConfigureCellBlock configureCell = ^(NSIndexPath* indexPath,id obj,UITableViewCell* cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    };

    CellHeightBlock heightBlock                  = ^CGFloat(NSIndexPath* indexPath,id item){
        if (indexPath.row == 0) {
            return [MeBaseInfoCellWithPhoto getCellHeightWithCustomObj:item indexPath:indexPath];
        } else {
            return [MeBaseInfoCellWithTwoLabels getCellHeightWithCustomObj:item indexPath:indexPath];
        }
    };
    
    CellIdentifierBlock cellIdentifier = ^NSString* (NSIndexPath* indexPath, id item){
        if (indexPath.row == 0) {
            return [MeBaseInfoCellWithPhoto getCellIdentifierWithCustomObj:item indexPath:indexPath];
        } else {
            return [MeBaseInfoCellWithTwoLabels getCellIdentifierWithCustomObj:item indexPath:indexPath];
        }
    };

    DidSelectCellBlock selectBlock                = ^(NSIndexPath* indexPath, id item){
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:true];
        switch (indexPath.row) {
            //头像
            case 0:
                [self uploadImage];
                break;
                
            //姓名
            case 1:
                [self performSegueWithIdentifier:@"toEditName" sender:nil];
                break;
                
            //性别
            case 2:
                [self pickSex];
                break;
                
            //出生年月
            case 3:
                _pickview = [[ZHPickView alloc]initDatePickviewWithHaveNavControler:NO];
                _pickview.delegate = self;
                _pickview.tag = 3;
                [_pickview show];
                break;
                
            //工作城市
            case 4:
                _pickview=[[ZHPickView alloc]initPickviewWithPlistName:@"city" isHaveNavControler:NO];
                _pickview.delegate = self;
                _pickview.tag = 4;
                [_pickview show];
                break;
                
            //行业职能
            case 5:
                
                break;
                
            //公司
            case 6:
                [self performSegueWithIdentifier:@"toEditCompanyName" sender:nil];
                break;
                
            //职位
            case 7:
                [self performSegueWithIdentifier:@"toEditPosition" sender:nil];
                break;
                
            //个人简介
            case 8:
                [self performSegueWithIdentifier:@"toEditSelfIntro" sender:nil];
                break;
                
            //职业经历
            case 9:
                [self performSegueWithIdentifier:@"toToAddJobExpVC" sender:nil];
                break;
                
            default:
                break;
        }
    };
    
    self.tableHandler = [[TableViewDataSourceDelegate alloc]initWithSections:self.sectionItemsArray
                                                          configureCellBlock:configureCell
                                                         cellIdentifierBlock:cellIdentifier
                                                             cellHeightBlock:heightBlock
                                                              didSelectBlock:selectBlock];
    
    [self.tableHandler HandleTableViewDataSourceAndDelegate:self.tableView];
    
}

-(void)uploadImage{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self  goCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goImage];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    [self presentViewController:actionSheet animated:true completion:nil];
}

-(void)goCamera{
    //先设定sourceType
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = true;
    picker.sourceType = sourceType;
    
    [self  presentViewController:picker animated:true completion:nil];
}

-(void)goImage{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
    }
    imagePicker.delegate = self;
    imagePicker.allowsEditing = true;
    
    [self presentViewController:imagePicker animated:true completion:nil];
}

//选好照片后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    NSIndexPath *indexPath        = [NSIndexPath indexPathForRow:0 inSection:0];
    MeBaseInfoCellWithPhoto *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.photo setImage:[Config handlePicture:image toAimSise:cell.photo.frame.size isZipped:true]];
    
    [picker dismissViewControllerAnimated:true completion:nil];
    
}

///取消选择后
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString* identifier = segue.identifier;
    if ([identifier isEqualToString:@"toEditName"]) {
        EditNameVC *nameVC = segue.destinationViewController;
        nameVC.getNameBK = ^(NSString *str){
            MeBaseInfoCellWithTwoLabels *cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.operationLabel.text = str;
            cell.operationLabel.textColor = [UIColor darkGrayColor];
        };
    }else if([identifier isEqualToString:@"toEditCompanyName"]){
        EditCompanyNameVC *companyNameVC = segue.destinationViewController;
        companyNameVC.getCompanyNameBK = ^(NSString* str){
            MeBaseInfoCellWithTwoLabels* cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
            cell.operationLabel.text = str;
            cell.operationLabel.textColor = [UIColor darkGrayColor];
        };
    }else if([identifier isEqualToString:@"toEditPosition"]){
        EditPositionVC *positionVC = segue.destinationViewController;
        positionVC.getPositionBK = ^(NSString* str){
            MeBaseInfoCellWithTwoLabels* cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
            cell.operationLabel.text = str;
            cell.operationLabel.textColor = [UIColor darkGrayColor];
        };
    }else if([identifier isEqualToString:@"toEditSelfIntro"]){
        EditSelfIntroVC *selfIntroVC = segue.destinationViewController;
        selfIntroVC.getSelfInfoBK = ^(NSString* str){
            MeBaseInfoCellWithTwoLabels* cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
            cell.operationLabel.text = str;
            cell.operationLabel.textColor = [UIColor darkGrayColor];
        };
    }
}

//选择性别
-(void)pickSex
{
    MeBaseInfoCellWithTwoLabels* cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UIAlertController* pickSexActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* action_male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.operationLabel.text = @"男";
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    }];
    
    UIAlertAction* action_female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.operationLabel.text = @"女";
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    }];
    
    UIAlertAction* action_secret = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.operationLabel.text = @"保密";
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    }];
    
    UIAlertAction* action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [pickSexActionSheet addAction:action_male];
    [pickSexActionSheet addAction:action_female];
    [pickSexActionSheet addAction:action_secret];
    [pickSexActionSheet addAction:action_cancel];
    
    [self presentViewController:pickSexActionSheet animated:YES completion:nil];
}




#pragma mark ZHPickviewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if (pickView.tag == 3) {
        MeBaseInfoCellWithTwoLabels *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.operationLabel.text = resultString;
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    } else {
        MeBaseInfoCellWithTwoLabels *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        cell.operationLabel.text = resultString;
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    }
}

@end
