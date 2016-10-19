//
//  SZTopColumnModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZRankModel : NSObject<YYModel>

@property (nonatomic , strong) NSNumber *top_Column_id;

@property (nonatomic , strong) NSNumber *mark_style;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , strong) NSNumber *update_at;

@end


@interface SZTopColumnModel : NSObject<YYModel>


@property (nonatomic , copy) NSArray *ranks;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
