//
//  Contact.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/11.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) UIImage  *photo;

@property NSInteger sectionNumber;  // Index

@end
