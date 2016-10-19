//
//  SZCategoryColleVCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCategoryColleVCell.h"
#import "SZNetWorkingTool.h"
#import "NSDictionary+GeneratePropertyCodes.h"
#import "SZCategoryColumnModel.h"
#import "SZChannelGroupModel.h"



@implementation SZCategoryColleVCell


- (void)awakeFromNib
{


}


- (void)loadNetworkingColumnData
{

    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    //根据栏目的id，拼接成对应的URL
    
    //女票URL：http://api.liwushuo.com/v2/channels/10/items_v2?gender=1&limit=20&offset=0&generation=1
    
    NSString *urlStr = @"columns";
    //    NSLog(@"urlStr = %@" , urlStr);
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dict = %@" , dict);
        
        SZCategoryColumnModel *model = [SZCategoryColumnModel modelWithDictionary:dict[@"data"]];
        
        //将数据传给表视图
        self.contentTableView.columnModel = model;
        
        
        //有了表视图第一个cell数据，再次请求其他cell的数据
        [self _loadOtherColumnData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败!!");
        
    }];
}



- (void)_loadOtherColumnData
{

    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    

    NSString *urlStr = @"channel_groups/all";

    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"dict = %@" , dict);

        SZChannelGroupModel *model = [SZChannelGroupModel modelWithDictionary:dict[@"data"]];
        
        self.contentTableView.groupModel = model;
        
//        SZCategoryChannelModel *channel = ;
        
//        NSLog(@"%@" , [[model.channel_groups[0] channels][0] name]);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败!!");
        
    }];
}




@end
