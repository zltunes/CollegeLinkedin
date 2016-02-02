//
//  CellWithTextView.m
//  CollegeLinkedin
//
//  Created by 赵磊 on 16/2/1.
//  Copyright © 2016年 赵磊. All rights reserved.
//

#import "CellWithTextView.h"

@implementation CellWithTextView

- (void)awakeFromNib {
    // Initialization code
    
    if (self.textView.text.length == 0) {
        self.promptLabel.hidden = NO;
    } else {
        self.promptLabel.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
