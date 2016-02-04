//
//  Config.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/24.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import "Config.h"
#import "SVProgressHUD.h"

static UIColor *backgroundColor = nil;

static UIColor *tintColor = nil;

static UIView *tableViewFooter = nil;

static const CGFloat sectionHeaderHeight = 11.0f;

static NSDictionary *infoPlistDict = nil;

static NSArray *industryArray = nil;

static UIViewController* VCFromSb = nil;

@implementation Config

///背景色
+(UIColor *)getBackgroundColor{
    backgroundColor                 = [UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1];
    
    return backgroundColor;
}

///主题色
+(UIColor *)getTintColor{
    tintColor = [UIColor colorWithRed:0 green:0.543 blue:0.795 alpha:1];
    
    return tintColor;
}

///tableFooterView
+(UIView *)getTableViewFooter{
    tableViewFooter                 = [[UIView alloc]init];
    tableViewFooter.backgroundColor = [UIColor redColor];
    
    return tableViewFooter;
}

//sectionHeaderHeight
+(CGFloat)getSectionHeaderHeight{
    return sectionHeaderHeight;
}

///infoPlistDict
+(NSDictionary*)getInfoPlistDict{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    infoPlistDict  = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return infoPlistDict;
}

///industry.json
+(NSArray*)getIndustryArray{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"json"];
//    industryArray = [NSArray arrayWithContentsOfFile:path];
    
    NSString *jsonStr  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *jaonData   = [[NSData alloc] initWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    industryArray = [NSJSONSerialization JSONObjectWithData:jaonData options:(NSJSONReadingMutableContainers) error:nil];
    
    return industryArray;
}

///从sb中获取独立vc
+(UIViewController*)getVCFromSb:(NSString*)storyboardID
{
    UIStoryboard* story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    VCFromSb = [story instantiateViewControllerWithIdentifier:storyboardID];
    
    return VCFromSb;
}

///indicator
+(void)showProgressHUDwithStatus:(NSString*) status{
    [SVProgressHUD showWithStatus:status];
}

+(void)dismissHUD{
    [SVProgressHUD dismiss];
}

+(void)showSuccessHUDwithStatus:(NSString*) status{
    [SVProgressHUD showSuccessWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
}

+(void)showErrorHUDwithStatus:(NSString*) status{
    [SVProgressHUD showErrorWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
}

///goback_alert
+(void)popAlertControllerWhenGobackWithRootVC:(UIViewController*)superVC{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"放弃编辑？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action_goback = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [superVC.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction* action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action_goback];
    [alert addAction:action_cancel];
    
    [superVC presentViewController:alert animated:YES completion:nil];
}


///压缩图片
+(UIImage*) handlePicture:(UIImage*) originPic toAimSise:(CGSize)aimSize isZipped:(BOOL)zipped{
    
    CGSize originSize = originPic.size;
    CGSize newSize    = aimSize;
    CGFloat wRate     = originSize.width / newSize.width;
    CGFloat hRate     = originSize.height / newSize.height;
    
    if(!zipped){
        if((originSize.width > aimSize.width)||(originSize.height > aimSize.height)){
            if(wRate < hRate){
                newSize = CGSizeMake(aimSize.width * hRate, originSize.height);
            }else{
                newSize = CGSizeMake(originSize.width, aimSize.height * wRate);
            }
        }
    }

    if(!((originSize.width == newSize.width)&&(originSize.height == newSize.height))){
        CGFloat wRate = originSize.width / newSize.width;
        CGFloat hRate = originSize.height / newSize.height;
        
        id imageRef = [[UIImage alloc]init].CGImage;
        
        if (hRate > wRate){
            imageRef = (CFBridgingRelease(CGImageCreateWithImageInRect(originPic.CGImage, CGRectMake(0, originSize.height / 2 - wRate * newSize.height / 2, originSize.width, wRate * newSize.height))));
        }else{
            imageRef = (CFBridgingRelease(CGImageCreateWithImageInRect(originPic.CGImage, CGRectMake(originSize.width / 2 - hRate * newSize.width / 2, 0, hRate * newSize.width, originSize.height))));
        }
        UIGraphicsBeginImageContext(newSize);
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, newSize.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, newSize.width, newSize.height), (CGImageRef)imageRef);
        UIImage *fImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return fImage;
    }else{
        return originPic;
    }
}

@end
