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
#import "TableViewDataSourceDelegate.h"
#import "UITableViewCell+Extension.h"

static NSString* const MeBaseInfoCellID0   = @"MeBaseInfoCellWithPhoto";
static NSString* const MeBaseInfoCellID1   = @"MeBaseInfoCellWithTwoLabels";

@interface MeBaseInfoIndexVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(strong,nonatomic) NSArray *cellItemsArray;
@property(strong,nonatomic) TableViewDataSourceDelegate* tableHandler;

@end

@implementation MeBaseInfoIndexVC

-(NSArray*)cellItemsArray{
    if(!_cellItemsArray){
        _cellItemsArray = [[Config getInfoPlistDict] objectForKey:@"MeBaseInfoCellItems"];
    }
    return _cellItemsArray;
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
        switch (indexPath.section) {
            case 0:
                return [MeBaseInfoCellWithPhoto getCellHeightWithCustomObj:item indexPath:indexPath];
                break;
                
            case 1:
                return [MeBaseInfoCellWithTwoLabels getCellHeightWithCustomObj:item indexPath:indexPath];
                break;
                
            default:
                return [UITableViewCell getCellHeightWithCustomObj:item indexPath:indexPath];
                break;
        }
    };

    DidSelectCellBlock selectBlock                = ^(NSIndexPath* indexPath, id item){
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:true];
        switch (indexPath.section) {
            case 0:
                [self uploadImage];
                break;
            
            case 1:
                switch (indexPath.row) {
                    case 0:
                        [self performSegueWithIdentifier:@"toEditName" sender:nil];
                        break;
                        
                    default:
                        break;
                }
                
            default:
                break;
        }
    };
    
    NSArray* cellItemArray0 = @[@"头像"];
    NSArray* identifierArray = @[MeBaseInfoCellID0,MeBaseInfoCellID1];
    NSArray* itemsArray = @[cellItemArray0,self.cellItemsArray];
    NSArray* sectionHeaderHeightsArray = @[[NSNumber numberWithFloat:[Config getSectionHeaderHeight]],[NSNumber numberWithFloat:0.0f]];
    
    NSDictionary* tableDataDict = @{@"identifier":identifierArray,@"items":itemsArray,@"sectionHeaderHeight":sectionHeaderHeightsArray};
    
    self.tableHandler = [[TableViewDataSourceDelegate alloc]initWithItems:tableDataDict
                                                       configureCellBlock:configureCell cellHeightBlock:heightBlock didSelectBlock:selectBlock];
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
    EditNameVC *nameVC = segue.destinationViewController;
    nameVC.getNameBK = ^(NSString *str){
        MeBaseInfoCellWithTwoLabels *cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.operationLabel.text = str;
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    };
}

@end
