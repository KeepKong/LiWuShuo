//
//  SZCycleModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>





@interface SZBannerModel : NSObject<YYModel , NSCoding>


@property (nonatomic , copy) NSString *webp_url;


@property (nonatomic , copy) NSString *image_url;


@property (nonatomic , copy) NSString *target_url;


@property (nonatomic , strong) NSDictionary *target;


@property (nonatomic , assign) NSInteger columnNumber;


@property (nonatomic , strong) NSNumber *request_id;


@property (nonatomic , copy) NSString *type;



@end



@interface SZCycleModel : NSObject<YYModel>



@property (nonatomic , copy) NSArray *banners;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
