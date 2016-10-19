//
//  SZfirstCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SZNetWorkingTool.h"
#import "NSDictionary+GeneratePropertyCodes.h"


@interface SZFirstCell ()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) SDCycleScrollView *cycleScrollView;



@end



@implementation SZFirstCell

- (void)awakeFromNib {

    
    //加载cell的时候自带一个轮播视图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 160) delegate:self placeholderImage:nil];


    
    //设置自动播放时间
    self.cycleScrollView.autoScrollTimeInterval = 4.f;
    
    [self.cycleBgView addSubview:self.cycleScrollView];
}

- (void)setCycleImageURLArr:(NSArray *)cycleImageURLArr
{

    if (_cycleImageURLArr != cycleImageURLArr)
    {
        _cycleImageURLArr = cycleImageURLArr;
    }
    
    
    
    //只要设置了这个，内部已经帮我们请求图片了
    self.cycleScrollView.imageURLStringsGroup = _cycleImageURLArr;
    
    
}


- (void)setSecondModelArr:(NSArray *)secondModelArr
{

    
    if (_secondModelArr != secondModelArr)
    {
        _secondModelArr = secondModelArr;
    }
    
    //将数据传给cell上的集合视图，让其刷新并显示数据
    self.secondCollView.secondModelArr = _secondModelArr;
    

}


#pragma mark - 点击图片回调方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    NSLog(@"选中了轮播视图的第%ld个视图" , index);
    SZBannerModel *bannerModel = self.bannerMuArr[index];
    
    NSLog(@"id = %@ , type = %@" , bannerModel.request_id , bannerModel.type);
    
    if (bannerModel.request_id != nil)
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KPushCycleDetailPage
            object:self
            userInfo:@{
                       @"request_id" : bannerModel.request_id
                      }];
    }
    
    

    
    
    //传递URL开始网络请求
//    [self _loadCycleDetailPageData:bannerModel];
    
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
