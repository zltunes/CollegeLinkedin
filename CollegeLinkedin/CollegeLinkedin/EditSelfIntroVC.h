//
//  EditSelfIntroVC.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 2016-01-31.
//  Copyright © 2016 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^getSelfInfoBKT)(NSString* str);

@interface EditSelfIntroVC : UIViewController<UITextViewDelegate>

@property(nonatomic,strong) getSelfInfoBKT getSelfInfoBK;

@end
