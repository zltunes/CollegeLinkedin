//
//  AddContactsVC.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/12.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "AddContactsVC.h"

static NSString* const cellID0   = @"CellWithImgAndTwoLabels";
static NSString* const cellID1   = @"defaultCellIdentifier";
static const CGFloat cell0Height = 60.0f;

@interface AddContactsVC ()

{
//    模拟 search 结果
    NSMutableArray* searchResults;
}

@end

@implementation AddContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchResults = [NSMutableArray arrayWithObjects:@"赵磊",@"赵磊磊", nil];
    
    self.tableView.tableFooterView = [Config getTableViewFooter];
    
    self.searchDisplayController.searchResultsTableView.tableFooterView = [Config getTableViewFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    } else {
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        cell.textLabel.text = searchResults[indexPath.row];
        return cell;
    } else {
        CellWithImgAndTwoLabels *cell = (CellWithImgAndTwoLabels*)[tableView dequeueReusableCellWithIdentifier:cellID0];
        switch (indexPath.row) {
            case 0:
                [cell.imgView setImage:[UIImage imageNamed:@"手机联系人"]];
                cell.topLabel.text    = @"手机联系人";
                cell.bottomLabel.text = @"添加或邀请手机通讯录中联系人";
                break;

            case 1:
                [cell.imgView setImage:[UIImage imageNamed:@"校友圈"]];
                cell.topLabel.text    = @"校友号";
                cell.bottomLabel.text = @"邀请校友圈联系人";
                break;

            case 2:
                [cell.imgView setImage:[UIImage imageNamed:@"扫一扫"]];
                cell.topLabel.text    = @"扫一扫";
                cell.bottomLabel.text = @"扫二维码添加好友";
                break;
                
            default:
                break;
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return cell0Height;
    }
    return 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    该方法中执行搜索并更新 searchResults 数组
    [searchResults addObject:@"赵磊3"];
}

@end
