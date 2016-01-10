//
//  MeBaseInfoItem.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeBaseInfoItem : NSObject

@property (copy,nonatomic  ) NSString * title;
@property (strong,nonatomic) NSString * content;

-(id)initWithTitle:(NSString*)title andContent:(NSString*)content;

@end
