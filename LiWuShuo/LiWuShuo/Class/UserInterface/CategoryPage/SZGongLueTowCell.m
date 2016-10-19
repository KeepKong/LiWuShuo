//
//  SZGongLueTowCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZGongLueTowCell.h"

@implementation SZGongLueTowCell

- (void)awakeFromNib {
    
    
    
    
    
}


- (void)setChannelModel:(SZCategoryChannelModel *)channelModel
{
    
    
    if (_channelModel != channelModel)
    {
        _channelModel = channelModel;
    }
    
    //设置cell上的分类名称
    self.typeLabel.text = _channelModel.name;
    
    
    self.otherCollView.channelsArr = [_channelModel.channels mutableCopy];
    
}

//- (void)setGroupModel:(SZChannelGroupModel *)groupModel
//{
//
//    
//    if (_groupModel != groupModel)
//    {
//        _groupModel = groupModel;
//    }
//    
//    
//    //将数据传递给集合视图，用于显示
//    self.otherCollView.channelsArr = [_groupModel.channel_groups mutableCopy];
//    
//    
//    
//}




- (IBAction)foundAllInfoAction:(UIButton *)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
