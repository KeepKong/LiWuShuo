//
//  SZADModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZSecondBanner : NSObject <YYModel , NSCoding>

@property (nonatomic , copy) NSString *target_url;


//@property (nonatomic , strong) NSNumber *id;


//@property (nonatomic , strong) NSArray *ad_monitors;


@property (nonatomic , copy) NSString *image_url;


@property (nonatomic , copy) NSString *webp_url;


@property (nonatomic , assign) NSInteger columnNumber;



@end



@interface SZADModel : NSObject<YYModel>


@property (nonatomic , copy) NSArray *secondary_banners;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
