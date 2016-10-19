//
//  SZNetWorkingTool.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SZNetWorkingTool : AFHTTPSessionManager

+ (AFHTTPSessionManager *)getBaseUrlSessionManager;

@end
