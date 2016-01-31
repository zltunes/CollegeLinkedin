//
//  EditCompanyNameVC.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 2016-01-31.
//  Copyright © 2016 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetCompanyNameBKT)(NSString* str);

@interface EditCompanyNameVC : UIViewController

@property(strong,nonatomic) GetCompanyNameBKT getCompanyNameBK;

@end
