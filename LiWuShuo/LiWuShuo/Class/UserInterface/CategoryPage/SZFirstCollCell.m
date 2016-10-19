//
//  SZFirstCollCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstCollCell.h"
#import <SDWebImage/UIImageView+WebCache.h>




@implementation SZFirstCollCell




- (void)setItemModel:(SZCategoryItemModel *)itemModel
{

    if (_itemModel != itemModel)
    {
        _itemModel = itemModel;
    }
    
    [self.columnImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.banner_image_url]];
    
    self.titleLabel.text = itemModel.title;
    self.authorLabel.text = itemModel.author;
    
    
}








- (void)awakeFromNib {

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    self.columnImageV.layer.cornerRadius = 3;
    
    self.columnImageV.layer.masksToBounds = YES;
    
    
}

@end
