//
//  SZNetWorkingTool.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZNetWorkingTool.h"

@implementation SZNetWorkingTool


+ (AFHTTPSessionManager *)getBaseUrlSessionManager
{

    static AFHTTPSessionManager *manager;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        NSString *baseStr = @"http://api.liwushuo.com/v2/";

        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseStr]];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        
    });

    
    return manager;
}


@end
