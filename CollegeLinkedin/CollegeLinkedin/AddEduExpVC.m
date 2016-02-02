//
//  AddEduExpVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/2.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "AddEduExpVC.h"
#import "Config.h"
#import "CellWithLabelAndTextField.h"
#import "CellWithTextView.h"
#import "ChooseTimeCell.h"
#import "ZHPickView.h"

static NSString* const cellId0 = @"CellWithLabelAndTextField";
static NSString* const cellId1 = @"ChooseTimeCell";
static NSString* const cellId2 = @"CellWithTextView";

static float heightForCellWithTextView = 150.f;

@interface AddEduExpVC ()<ZHPickViewDelegate>
{
    ZHPickView* pickView;
    NSString* schoolName;
    NSString* major;
    NSString* degree;
    NSString* beginTime;
    NSString* endTime;
    NSString* eduDescription;
}

@end

@implementation AddEduExpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [Config getTableViewFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return heightForCellWithTextView;
    }else{
        return 44;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"更多描述";
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CellWithLabelAndTextField* cell = (CellWithLabelAndTextField*)[tableView dequeueReusableCellWithIdentifier:cellId0];
            cell.itemLabel.text = @"学校";
            return cell;
        } else if(indexPath.row == 1){
            CellWithLabelAndTextField* cell = (CellWithLabelAndTextField*)[tableView dequeueReusableCellWithIdentifier:cellId0];
            cell.itemLabel.text = @"专业";
            return cell;
        }else if(indexPath.row == 2){
            CellWithLabelAndTextField* cell = (CellWithLabelAndTextField*)[tableView dequeueReusableCellWithIdentifier:cellId0];
            cell.itemLabel.text = @"学历";
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

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CellWithTextView* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.promptLabel.hidden = YES;
    return YES;
}


-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    ChooseTimeCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
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

- (IBAction)goBack:(id)sender {
    [Config popAlertControllerWhenGobackWithRootVC:self];
}

- (IBAction)save:(id)sender {
    CellWithLabelAndTextField* schoolCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CellWithLabelAndTextField* majorCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CellWithLabelAndTextField* degreeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    ChooseTimeCell* timeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CellWithTextView* eduDescriptionCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    schoolName     = schoolCell.textField.text;
    major          = majorCell.textField.text;
    degree         = degreeCell.textField.text;
    beginTime      = timeCell.beginTimeBtn.titleLabel.text;
    endTime        = timeCell.endTimeBtn.titleLabel.text;
    eduDescription = eduDescriptionCell.textView.text;
    
    if (schoolName.length==0){
        [Config showErrorHUDwithStatus:@"请填写公司"];
    }else if(major.length==0){
        [Config showErrorHUDwithStatus:@"请填写职位"];
    }else if(degree.length==0){
        [Config showErrorHUDwithStatus:@"请填写学历"];
    }else if([beginTime isEqualToString:@"请选择"] || [endTime isEqualToString:@"请选择"]){
        [Config showErrorHUDwithStatus:@"请选择在职时间"];
    }else{
        //保存并退出
        [self.navigationController popViewControllerAnimated:YES];
    }

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
