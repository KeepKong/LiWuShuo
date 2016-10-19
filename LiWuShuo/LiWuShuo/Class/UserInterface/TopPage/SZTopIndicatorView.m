//
//  SZTopIndicatorView.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopIndicatorView.h"

@implementation SZTopIndicatorView


+ (instancetype)defaultTopIndicatiorView
{

    static SZTopIndicatorView *topIndicatorView;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        topIndicatorView = [[SZTopIndicatorView alloc] init];
        
    });
    
    
    return topIndicatorView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
