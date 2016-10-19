//
//  SZRightCollCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZRightCollCell.h"
#import <UIImageView+WebCache.h>


@implementation SZRightCollCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(SZSubcategorieModel *)model
{

    
    if (_model != model)
    {
        _model = model;
    }
    
    [self.giftImageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];
    self.giftNameLabel.text = model.name;
    

}

@end
