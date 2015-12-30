//
//  Config.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 15/12/24.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Config : NSObject

+(UIColor *)getBackgroundColor;
+(UIView *)getTableViewFooter;
+(CGFloat)getSectionHeaderHeight;
+(NSDictionary*)getInfoPlistDict;
+(UIImage*) handlePicture:(UIImage*) originPic toAimSise:(CGSize)aimSize isZipped:(BOOL)zipped;
+(UIColor *)getTintColor;
+(void)showProgressHUDwithStatus:(NSString*) status;
+(void)dismissHUD;
+(void)showSuccessHUDwithStatus:(NSString*) status;
+(void)showErrorHUDwithStatus:(NSString*) status;

@end
