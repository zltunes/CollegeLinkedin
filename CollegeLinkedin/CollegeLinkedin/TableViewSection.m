
//
//  TableViewSection.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "TableViewSection.h"

@implementation TableViewSection

-(id)initWithHeaderTitle:(NSString*)title headerHeight:(CGFloat)height items:(NSArray*)items
{
    self.headerTitle  = title;
    self.headerHeight = height;
    self.items        = items;
    
    return self;
}

@end
