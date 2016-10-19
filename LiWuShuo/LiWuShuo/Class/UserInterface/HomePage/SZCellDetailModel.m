//
//  SZCellDetailModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/13.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCellDetailModel.h"

@implementation SZCellDetailModel


+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZCellDetailModel *model = [[self alloc] init];
    
    model = [SZCellDetailModel yy_modelWithDictionary:dict];
    
    return model;
    
}


@end
