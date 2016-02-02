//
//  CALayer_extensionCALayer.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/2.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface CALayer ()

@property(nonatomic,strong) UIColor* borderUIColor;

-(void)setBorderUIColor:(id)newValue;

-(UIColor*)getBorderUIColor;

@end


@implementation CALayer

-(void)setBorderUIColor:(id)newValue
{
    self.borderUIColor = newValue.CGColor;
}

-(UIColor*)getBorderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}


@end





