//
//  SZCycleDetailModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCycleDetailModel.h"

@implementation SZDetailColumnModel



@end

@implementation SZPostModel



@end




@implementation SZCycleDetailModel


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"posts" : [SZPostModel class]
             
             };
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZCycleDetailModel *model = [SZCycleDetailModel yy_modelWithDictionary:dict];
    
    
    
    return model;
}


@end
