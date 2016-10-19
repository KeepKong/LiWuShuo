//
//  SZFirstCellCollCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstCellCollCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface SZFirstCellCollCell ()

@property (nonatomic , strong) UIImageView *imgView;

@end


@implementation SZFirstCellCollCell

- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        self.imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        
        
        [self.contentView addSubview:self.imgView];
        
        
        
    }
    
    return self;
}

- (void)setSecondModel:(SZSecondBanner *)secondModel
{

    
    if (_secondModel != secondModel)
    {
        _secondModel = secondModel;
    }
    
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_secondModel.image_url]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_secondModel.image_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];

    
}


@end
