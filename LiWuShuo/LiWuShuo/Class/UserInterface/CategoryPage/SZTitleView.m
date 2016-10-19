//
//  SZTitleView.m
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTitleView.h"




@implementation SZTitleView




+ (instancetype)getIndicatorView
{

    static SZTitleView *titleView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        titleView = [[[NSBundle mainBundle]loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
        
        
    });
    
    return titleView;

}



- (IBAction)gongLueAction:(UIButton *)sender {
}

- (IBAction)danPinAction:(UIButton *)sender {
}










- (void)awakeFromNib
{


    
    [self.gongLueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.danPinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.indicatorView.backgroundColor = [UIColor whiteColor];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
