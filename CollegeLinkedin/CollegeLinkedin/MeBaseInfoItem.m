//
//  MeBaseInfoItem.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "MeBaseInfoItem.h"

@implementation MeBaseInfoItem

-(id)initWithTitle:(NSString*)title andContent:(NSString*)content
{
    self = [super init];
    if(self){
        self.title   = title;
        self.content = content;
    }
    return self;
}

@end
