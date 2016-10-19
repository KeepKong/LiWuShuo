//
//  SZCategoryDanPinCollVCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCategoryDanPinCollVCell.h"
#import "SZNetWorkingTool.h"
#import "NSDictionary+GeneratePropertyCodes.h"
#import "SZDanPinModel.h"


@interface SZCategoryDanPinCollVCell ()

//@property (nonatomic , strong) SZDanPinModel *danPinModel;

@end


@implementation SZCategoryDanPinCollVCell


- (void)loadDanPinData
{
    
    NSString *strURL = @"item_categories/tree";
    
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData *  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
//        [dict[@"data"][@"categories"][0][@"subcategories"][0] generatePropertyCodes];
        SZDanPinModel *danPinModel = [SZDanPinModel modelWithDictionary:dict[@"data"]];
        self.leftTableView.leftModel = danPinModel;
        self.rightTableView.rightModel = danPinModel;
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"单品页面数据请求失败!!");
        
    }];
    

    

}




@end
