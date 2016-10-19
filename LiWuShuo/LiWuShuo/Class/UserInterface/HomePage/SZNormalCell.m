//
//  SZNormalCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZNormalCell.h"
#import <SDWebImage/UIImageView+WebCache.h>



@implementation SZNormalCell

- (void)awakeFromNib {

    
    
    self.userImageV.layer.cornerRadius = self.userImageV.bounds.size.height/2.0;
    self.userImageV.layer.masksToBounds = YES;
    
//    self.typeLable.layer.cornerRadius = 5.0;
    self.typeBgView.layer.cornerRadius = 3.0;

    
}

- (void)setItemModel:(SZItemModel *)itemModel
{
    
    if (_itemModel != itemModel)
    {
        _itemModel = itemModel;
    }
    
    //计算类型文本的宽度
    //计算类型文本需要的宽度
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f
                        
                        };
    CGSize size=[itemModel.column.category boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;

    
    self.typeViewWidth.constant = size.width;
    
    //设置类型文本
    self.typeLable.text = itemModel.column.category;
    
    
    
    
    
    
    
    //设置栏目标题
    self.columnTitle.text = itemModel.column.title;
    //设置用户图片
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.author.avatar_url]];
    //设置用户名称
    self.userName.text = itemModel.author.nickname;
    
    //设置内容大图
    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.cover_image_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];

//    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.cover_image_url]];
    //设置礼物标题
    self.title.text = itemModel.title;
    //设置喜爱数
    self.favoriteLabel.text = [NSString stringWithFormat:@"%ld" , [itemModel.likes_count integerValue]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
