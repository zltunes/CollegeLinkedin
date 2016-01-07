//
//  ArrayDataSource.h
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/1/6.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject <UITableViewDataSource>

-(id)initWithItems:(NSArray*)anItems
    cellIdentifier:(NSString*)aCellIdentifier
configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

-(id)itemAtIndexPath:(NSIndexPath*)indexPath;

@end
