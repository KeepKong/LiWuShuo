//
//  SZChannelGroupModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>

@interface SZCategoryChannelItemModel : NSObject<YYModel>

//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *group_id;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , strong) NSNumber *items_count;

@property (nonatomic , strong) NSNumber *order;
/**
 *
 */
@property (nonatomic , copy) NSString *icon_url;
/**
 *  覆盖大图
 */
@property (nonatomic , copy) NSString *cover_image_url;

/**
 *  名称
 */
@property (nonatomic , copy) NSString *name;

//@property (nonatomic , copy) NSString *url;

@end


@interface SZCategoryChannelModel : NSObject<YYModel>

//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , strong) NSArray *channels;

@property (nonatomic , strong) NSNumber *order;

@property (nonatomic , copy) NSString *name;

@end



@interface SZChannelGroupModel : NSObject<YYModel>



@property (nonatomic , strong) NSArray *channel_groups;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;




@end
