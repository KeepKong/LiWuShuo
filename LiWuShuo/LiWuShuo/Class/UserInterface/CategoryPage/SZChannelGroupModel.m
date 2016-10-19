//
//  SZChannelGroupModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZChannelGroupModel.h"

@implementation SZCategoryChannelItemModel





@end



@implementation SZCategoryChannelModel




+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"channels" : [SZCategoryChannelItemModel class]
             };
}



@end








@implementation SZChannelGroupModel



+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    
    SZChannelGroupModel *model = [[self alloc] init];
    
    model = [SZChannelGroupModel yy_modelWithDictionary:dict];
    
    
    return model;
    
}






+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"channel_groups" : [SZCategoryChannelModel class]
             };
}








@end
