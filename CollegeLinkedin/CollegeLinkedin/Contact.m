//
//  Contact.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/11.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+(NSDictionary*) mj_replacedKeyFromPropertyName
{
    return @{
             @"contact_id":@"user_id",
             @"name":@"user_name",
             @"photo":@"image",
             @"job":@"user_job",
             @"school":@"user_school"
             };
}

@end
