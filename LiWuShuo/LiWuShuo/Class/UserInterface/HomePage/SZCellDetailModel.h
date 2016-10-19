//
//  SZCellDetailModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/13.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>



@interface SZCellDetailModel : NSObject<YYModel>

/**
 *  栏目
 */
@property (nonatomic , strong) NSDictionary *column;

//column_header:(NULL)

//@property (nonatomic , copy) NSString *cover_webp_url;

@property (nonatomic , assign) BOOL liked;

//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *editor_id;

/**
 *  标题
 */
@property (nonatomic , copy) NSString *title;

//ad_monitors:(NULL)

@property (nonatomic , copy) NSString *url;

//column_bottom:(NULL)

//@property (nonatomic , strong) NSNumber *published_at;

//@property (nonatomic , strong) NSNumber *updated_at;
/**
 *  评论数
 */
@property (nonatomic , strong) NSNumber *comments_count;

@property (nonatomic , strong) NSDictionary *item_ad_monitors;

//limit_end_at:(NULL)

//@property (nonatomic , copy) NSString *template;

//@property (nonatomic , strong) NSArray *feature_list;

@property (nonatomic , strong) NSNumber *shares_count;

//@property (nonatomic , copy) NSString *content_html;

//@property (nonatomic , strong) NSArray *label_ids;

//@property (nonatomic , strong) NSNumber *id;

//@property (nonatomic , strong) NSNumber *content_type;

@property (nonatomic , copy) NSString *content_url;

@property (nonatomic , copy) NSString *share_msg;

@property (nonatomic , strong) NSNumber *likes_count;

@property (nonatomic , copy) NSString *introduction;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , copy) NSString *short_title;

//content:(NULL)

@property (nonatomic , copy) NSString *cover_image_url;





+ (instancetype)modelWithDictionary:(NSDictionary *)dict;



@end
