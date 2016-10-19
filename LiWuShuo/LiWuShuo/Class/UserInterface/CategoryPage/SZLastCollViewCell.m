//
//  SZLastCollViewCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZLastCollViewCell.h"

@implementation SZLastCollViewCell

- (void)awakeFromNib {

    
    self.foundButn.layer.cornerRadius = 3;
    self.foundButn.layer.borderColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1].CGColor;
    self.foundButn.layer.borderWidth = 1;
    
    
    
}

- (IBAction)foundAction:(UIButton *)sender
{
    
    NSLog(@"点击了查看全部按钮！！");
    
}


@end
