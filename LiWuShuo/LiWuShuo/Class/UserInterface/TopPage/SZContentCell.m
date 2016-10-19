//
//  SZContentCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZContentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation SZContentCell

- (void)awakeFromNib {

    
    
    
    
    
}


- (void)setItemModel:(SZTopItemModel *)itemModel
{

    if (_itemModel != itemModel)
    {
        _itemModel = itemModel;
    }
    
    
    [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.cover_image_url]];
    
    self.shortDescriptionLabel.text = itemModel.short_description;
    self.nameLabel.text = itemModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@" , itemModel.price];
    
}

@end
