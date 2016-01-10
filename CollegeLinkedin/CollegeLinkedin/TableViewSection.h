//
//  TableViewSection.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/10.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewSection : NSObject

@property (copy,nonatomic  ) NSString * headerTitle;
@property (strong,nonatomic) NSArray  * items;
@property (nonatomic       ) CGFloat  headerHeight;

-(id)initWithHeaderTitle:(NSString*)title headerHeight:(CGFloat)height items:(NSArray*)items;

@end

