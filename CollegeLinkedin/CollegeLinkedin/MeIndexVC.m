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

static NSString* const MeCellID0         = @"MeCellWithPhoto";
static const CGFloat MeCell0Height       = 80.0f;
static NSString* const MeCellID1         = @"MeCellWithIcon";
static const CGFloat MeCell1Height       = 44.0f;
static const CGFloat sectionHeaderHeight = 11.0f;

@interface MeIndexVC ()

@property(strong,nonatomic) NSArray *cellItemArray;

@end

@implementation MeIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cellItemArray          = [[Config getInfoPlistDict] objectForKey:@"MeVCCellItems"];
    
    self.tableView.tableFooterView = [Config getTableViewFooter];
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
        case 0:
            [self performSegueWithIdentifier:@"toMeBaseInfo" sender:nil];
            break;
            
        default:
            break;
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
