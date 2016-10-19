//
//  SZIndicatorView.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZIndicatorView.h"

@implementation SZIndicatorView

+ (instancetype)defaultIndicatiorView
{

    static SZIndicatorView *indicatorView;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        indicatorView = [[self alloc] init];
        
    });
    
    
    return indicatorView;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
