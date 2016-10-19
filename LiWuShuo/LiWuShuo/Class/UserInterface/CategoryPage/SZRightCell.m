//
//  SZRightCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZRightCell.h"

@implementation SZRightCell

- (void)awakeFromNib {
    // Initialization code
    self.contentCollV.backgroundColor = [UIColor whiteColor];
    self.contentCollV.showsVerticalScrollIndicator = NO;
    self.contentCollV.showsHorizontalScrollIndicator = NO;
    self.contentCollV.bounces = NO;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
