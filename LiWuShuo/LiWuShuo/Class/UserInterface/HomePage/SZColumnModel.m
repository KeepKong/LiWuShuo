//
//  SZColumnModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnModel.h"

@implementation SZChannel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    
    return @{
             
             @"column_id" : @"id"
             
             };
}



@end


@implementation SZColumnModel




+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZColumnModel *model = [[self alloc] init];
    
    model = [SZColumnModel yy_modelWithDictionary:dict];
    
    
    return model;
}



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    

    return @{
             
             @"channels" : [SZChannel class]
             
             };
    
    
    
    
}


@end
