//
//  MeBaseInfoPhotoItem.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MeBaseInfoPhotoItem : NSObject

@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) UIImage  * photo;

-(id) initWithTitle:(NSString*)title andPhoto:(UIImage*)photo;

@end
