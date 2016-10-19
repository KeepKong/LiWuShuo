//
//  SZOtherCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/9.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZOtherCell.h"

#import <SDWebImage/UIImageView+WebCache.h>


@implementation SZOtherCell


- (void)setUrlStr:(NSString *)urlStr
{

    if (_urlStr != urlStr)
    {
        _urlStr = urlStr;
    }
    
    
    [self.otherImageView sd_setImageWithURL:[NSURL URLWithString:_urlStr]];
    
    
}


- (void)awakeFromNib {

    
    self.otherImageView.layer.cornerRadius = 3;
    
    self.otherImageView.layer.masksToBounds = YES;
    
    
    
}

@end
