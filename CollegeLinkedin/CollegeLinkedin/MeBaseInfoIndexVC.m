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
//static const CGFloat MeBaseInfoCell0Height = 74.0f;
static NSString* const MeBaseInfoCellID1   = @"MeBaseInfoCellWithTwoLabels";
//static const CGFloat MeBaseInfoCell1Height = 45.0f;

@interface MeBaseInfoIndexVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(strong,nonatomic) NSArray *cellItemsArray;
@property(strong,nonatomic) TableViewDataSourceDelegate* tableHandler0;
@property(strong,nonatomic) TableViewDataSourceDelegate* tableHandler1;

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
    
//    self.cellItemsArray = [[Config getInfoPlistDict] objectForKey:@"MeBaseInfoCellItems"];
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTableView{
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
    TableViewCellConfigureCellBlock configureCell = ^(NSIndexPath* indexPath,id obj,UITableViewCell* cell){
        [cell configure:cell customObj:obj indexPath:indexPath];
    };

    CellHeightBlock heightBlock0                  = ^CGFloat(NSIndexPath* indexPath,id item){
        return [MeBaseInfoCellWithPhoto getCellHeightWithCustomObj:item indexPath:indexPath];
    };

    CellHeightBlock heightBlock1                  = ^CGFloat(NSIndexPath* indexPath,id item){
        return [MeBaseInfoCellWithTwoLabels getCellHeightWithCustomObj:item indexPath:indexPath];
    };

    DidSelectCellBlock selectBlock                = ^(NSIndexPath* indexPath, id item){
        NSLog(@"%ld",(long)indexPath.row);
    };
    
    self.tableHandler0 = [[TableViewDataSourceDelegate alloc]initWithItems:self.cellItemsArray
                                                            cellIdentifier:MeBaseInfoCellID0
                                                        configureCellBlock:configureCell cellHeightBlock:heightBlock0 didSelectBlock:selectBlock];
    
    self.tableHandler1 = [[TableViewDataSourceDelegate alloc]initWithItems:self.cellItemsArray
                                                            cellIdentifier:MeBaseInfoCellID1
                                                        configureCellBlock:configureCell cellHeightBlock:heightBlock1 didSelectBlock:selectBlock];
    
    [self.tableHandler0 HandleTableViewDataSourceAndDelegate:self.tableView];
    [self.tableHandler1 HandleTableViewDataSourceAndDelegate:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Config getSectionHeaderHeight];
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        MeBaseInfoCellWithPhoto *cell     = (MeBaseInfoCellWithPhoto*)[tableView dequeueReusableCellWithIdentifier:MeBaseInfoCellID0];
        cell.photo.backgroundColor        = [UIColor redColor];

        return cell;
    } else {
        MeBaseInfoCellWithTwoLabels *cell = (MeBaseInfoCellWithTwoLabels*)[tableView dequeueReusableCellWithIdentifier:MeBaseInfoCellID1];
        cell.itemLabel.text               = self.cellItemsArray[indexPath.row-1];
        if (indexPath.row > 1 && indexPath.row < 6) {
        cell.operationLabel.text          = @"请选择";
        } else {
        cell.operationLabel.text          = @"请填写";
        }
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return MeBaseInfoCell0Height;
    } else {
        return MeBaseInfoCell1Height;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.row) {
        case 0:
            [self uploadImage];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"toEditName" sender:nil];
            break;
            
        default:
            break;
    }
}
*/

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
        MeBaseInfoCellWithTwoLabels *cell = (MeBaseInfoCellWithTwoLabels*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.operationLabel.text = str;
        cell.operationLabel.textColor = [UIColor darkGrayColor];
    };
}

@end
