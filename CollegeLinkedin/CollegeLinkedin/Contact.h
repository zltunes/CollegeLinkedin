//
//  Contact.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/11.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJExtension.h"

@interface Contact : NSObject

@property (nonatomic,assign) NSInteger contact_id;
@property (nonatomic,copy  ) NSString  *name;
@property (nonatomic,copy  ) NSString  *photo;
@property (nonatomic,copy  ) NSString  *job;
@property (nonatomic,copy  ) NSString  *school;

@end
