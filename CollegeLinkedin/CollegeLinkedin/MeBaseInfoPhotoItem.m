//
//  MeBaseInfoPhotoItem.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "MeBaseInfoPhotoItem.h"

@implementation MeBaseInfoPhotoItem

-(id) initWithTitle:(NSString*)title andPhoto:(UIImage*)photo
{
    self = [super init];
    if(self){
        self.title = title;
        self.photo = photo;
    }
    return self;
}

@end
