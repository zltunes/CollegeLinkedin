//
//  AddJobExpVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/1.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "AddJobExpVC.h"
#import "Config.h"
#import "CellWithLabelAndTextField.h"
#import "CellWithTextView.h"
#import "ChooseTimeCell.h"
#import "ZHPickView.h"

static NSString* const cellId0 = @"CellWithLabelAndTextField";
static NSString* const cellId1 = @"ChooseTimeCell";
static NSString* const cellId2 = @"CellWithTextView";

static float heightForCellWithTextView = 150.0f;

@interface AddJobExpVC ()<ZHPickViewDelegate>
{
    ZHPickView* pickView;
    NSString* companyName;
    NSString* position;
    NSString* beginTime;
    NSString* endTime;
    NSString* positionDescription;
}
@end

@implementation AddJobExpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [Config getTableViewFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return heightForCellWithTextView;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"职位描述";
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CellWithLabelAndTextField* cell = (CellWithLabelAndTextField*)[tableView dequeueReusableCellWithIdentifier:cellId0];
            cell.itemLabel.text = @"公司";
            return cell;
        } else if(indexPath.row == 1){
            CellWithLabelAndTextField* cell = (CellWithLabelAndTextField*)[tableView dequeueReusableCellWithIdentifier:cellId0];
            cell.itemLabel.text = @"职位";
            return cell;
        }else{
            ChooseTimeCell* cell = (ChooseTimeCell*)[tableView dequeueReusableCellWithIdentifier:cellId1];
            [cell.beginTimeBtn addTarget:self action:@selector(selectBeginTime:) forControlEvents:UIControlEventTouchUpInside];
            [cell.endTimeBtn addTarget:self action:@selector(selectEndTime:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }

    } else {
        CellWithTextView *cell = (CellWithTextView*)[tableView dequeueReusableCellWithIdentifier:cellId2];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)goBack:(id)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    
    CellWithLabelAndTextField* companyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CellWithLabelAndTextField* positionCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ChooseTimeCell* timeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    CellWithTextView* jobDescriptionCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    companyName = companyCell.textField.text;
    position = positionCell.textField.text;
    beginTime = timeCell.beginTimeBtn.titleLabel.text;
    endTime = timeCell.endTimeBtn.titleLabel.text;
    positionDescription = jobDescriptionCell.textView.text;
    
    if (companyName.length==0){
        [Config showErrorHUDwithStatus:@"请填写公司"];
    }else if(position.length==0){
        [Config showErrorHUDwithStatus:@"请填写职位"];
    }else if([beginTime isEqualToString:@"请选择"] || [endTime isEqualToString:@"请选择"]){
        [Config showErrorHUDwithStatus:@"请选择在职时间"];
    }else{
        //保存并退出
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CellWithTextView* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.promptLabel.hidden = YES;
    return YES;
}


-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    ChooseTimeCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (pickView.tag == 0) {
        [cell.beginTimeBtn setTitle:resultString forState:UIControlStateNormal];
    } else {
        [cell.endTimeBtn setTitle:resultString forState:UIControlStateNormal];
    }
}

-(void)selectBeginTime:(UIButton*)btn
{
    pickView = [[ZHPickView alloc]initDatePickviewWithHaveNavControler:NO isYearMonthType:YES isYearMonthTypeWithNow:NO];
    pickView.delegate = self;
    pickView.tag = 0;
    [pickView show];
}

-(void)selectEndTime:(UIButton*)btn
{
    pickView = [[ZHPickView alloc]initDatePickviewWithHaveNavControler:NO isYearMonthType:NO isYearMonthTypeWithNow:YES];
    pickView.delegate = self;
    pickView.tag = 1;
    [pickView show];
}

@end
