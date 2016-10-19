//
//  SZCategoryColumnModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCategoryColumnModel.h"

@implementation SZCategoryItemModel



@end



@implementation SZCategoryColumnModel


+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZCategoryColumnModel *model = [[self alloc] init];
    
    model = [SZCategoryColumnModel yy_modelWithDictionary:dict];
    
    
    return model;
    
}


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"columns" : [SZCategoryItemModel class]
             
             };
}

@end
