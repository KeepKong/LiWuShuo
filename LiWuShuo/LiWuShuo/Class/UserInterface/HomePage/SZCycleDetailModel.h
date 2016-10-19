//
//  SZCycleDetailModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZDetailColumnModel : NSObject<YYModel>


@property (nonatomic , copy) NSString *title;


@end




@interface SZPostModel : NSObject<YYModel>


@property (nonatomic , strong) SZDetailColumnModel *column;

//@property (nonatomic , copy) NSString *cover_webp_url;

//@property (nonatomic , assign) BOOL liked;

//@property (nonatomic , strong) NSNumber *status;

@property (nonatomic , copy) NSString *title;

//@property (nonatomic , strong) NSNumber *editor_id;

//@property (nonatomic , copy) NSString *url;

//@property (nonatomic , strong) NSArray *ad_monitors;

//@property (nonatomic , strong) NSNumber *published_at;

//@property (nonatomic , strong) NSNumber *updated_at;

//limit_end_at:(NULL)

//@property (nonatomic , copy) NSString *template;

//@property (nonatomic , strong) NSArray *feature_list;

@property (nonatomic , copy) NSString *type;

//@property (nonatomic , strong) NSArray *label_ids;

//@property (nonatomic , strong) NSNumber *id;

//@property (nonatomic , strong) NSNumber *content_type;

@property (nonatomic , copy) NSString *content_url;

@property (nonatomic , copy) NSString *share_msg;

@property (nonatomic , strong) NSNumber *likes_count;

@property (nonatomic , copy) NSString *introduction;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , copy) NSString *short_title;

//@property (nonatomic , strong) NSDictionary *author;

@property (nonatomic , copy) NSString *cover_image_url;


@end









@interface SZCycleDetailModel : NSObject<YYModel>


//@property (nonatomic , copy) NSString *cover_image_url;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , strong) NSNumber *posts_count;

//@property (nonatomic , copy) NSString *banner_webp_url;

//@property (nonatomic , copy) NSString *subtitle;

//@property (nonatomic , copy) NSString *banner_image_url;

//@property (nonatomic , copy) NSString *cover_webp_url;

//@property (nonatomic , strong) NSNumber *created_at;

@property (nonatomic , strong) NSArray *posts;

@property (nonatomic , copy) NSString *url;

@property (nonatomic , copy) NSString *title;

//@property (nonatomic , strong) NSNumber *updated_at;

//@property (nonatomic , strong) NSDictionary *paging;

//@property (nonatomic , strong) NSNumber *status;



+ (instancetype)modelWithDictionary:(NSDictionary *)dict;



@end
