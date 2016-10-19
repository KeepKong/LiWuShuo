//
//  SZTopContentModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZTopItemModel : NSObject<YYModel , NSCoding>


/**
 *  标记那个栏目
 */
@property (nonatomic , assign) NSInteger columnNumber;




//@property (nonatomic , copy) NSString *description;

//@property (nonatomic , strong) NSNumber *editor_id;

//礼物详情页面
@property (nonatomic , copy) NSString *url;


/**
 *  购买网址
 */
@property (nonatomic , copy) NSString *purchase_url;


//@property (nonatomic , strong) NSArray *image_urls;

//@property (nonatomic , strong) NSNumber *updated_at;

//@property (nonatomic , copy) NSString *keywords;

@property (nonatomic , strong) NSNumber *purchase_type;

//brand_id:(NULL)

/**
 *  礼物名称
 */
@property (nonatomic , copy) NSString *name;

//@property (nonatomic , strong) NSArray *post_ids;

//@property (nonatomic , strong) NSNumber *purchase_status;

@property (nonatomic , strong) NSNumber *favorites_count;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , copy) NSString *short_description;

//@property (nonatomic , copy) NSString *purchase_shop_id;

//@property (nonatomic , copy) NSString *purchase_id;

//brand_order:(NULL)

//@property (nonatomic , strong) NSNumber *subcategory_id;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , strong) NSNumber *order;

//@property (nonatomic , strong) NSNumber *category_id;

/**
 *  出售价格
 */
@property (nonatomic , copy) NSString *price;

//@property (nonatomic , copy) NSString *cover_webp_url;

/**
 *  物品图片
 */
@property (nonatomic , copy) NSString *cover_image_url;

@end



@interface SZTopContentModel : NSObject<YYModel , NSCoding>

/**
 *  标记是哪一个栏目的
 */
@property (nonatomic , assign) NSInteger columnNumber;



@property (nonatomic , strong) NSDictionary *paging;

@property (nonatomic , copy) NSString *share_url;

//@property (nonatomic , copy) NSString *cover_webp;

//@property (nonatomic , copy) NSString *cover_url;

@property (nonatomic , strong) NSArray *items;

@property (nonatomic , copy) NSString *cover_image;





+ (instancetype)modelWithDictionary:(NSDictionary *)dict;







@end
