//
//  SZDetailCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZDetailCell.h"
#import <UIImageView+WebCache.h>



@implementation SZDetailCell

- (void)awakeFromNib {
    // Initialization code
    
//    self.contentView.backgroundColor = [UIColor purpleColor];
    
}


- (void)setPostModel:(SZPostModel *)postModel
{

    if (_postModel != postModel)
    {
        _postModel = postModel;
    }
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:postModel.cover_image_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];
    
    self.titleLabel.text = postModel.title;
    self.detailLabel.text = postModel.introduction;
    self.columnTitleLabel.text = postModel.column.title;
    [self.favoriteBtn setTitle:[NSString stringWithFormat:@"%ld" , [postModel.likes_count integerValue]] forState:UIControlStateNormal];
    
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
