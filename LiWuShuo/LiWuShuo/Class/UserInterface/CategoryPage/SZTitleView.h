//
//  SZTitleView.h
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTitleView : UIView



@property (weak, nonatomic) IBOutlet UIButton *gongLueBtn;

@property (weak, nonatomic) IBOutlet UIButton *danPinBtn;


@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMagin;


+ (instancetype)getIndicatorView;



@end
