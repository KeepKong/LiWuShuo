//
//  SZTopColumnModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopColumnModel.h"

@implementation SZRankModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{

    return @{
             
             @"top_Column_id" : @"id"
             
             };
}

@end


@implementation SZTopColumnModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZTopColumnModel *model = [[self alloc] init];
    
    model = [SZTopColumnModel yy_modelWithDictionary:dict];
    
    return model;
    
    
}




+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"ranks" : [SZRankModel class]
             
             };
}


@end
