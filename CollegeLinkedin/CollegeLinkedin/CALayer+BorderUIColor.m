
//
//  CALayer+BorderUIColor.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/15.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CALayer+BorderUIColor.h"

@implementation CALayer (BorderUIColor)

-(void)setBorderUIColor:(UIColor *)borderUIColor
{
    self.borderColor = [borderUIColor CGColor];
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}


@end
