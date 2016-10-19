//
//  SZNormalCellModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>




@interface SZColumn : NSObject<YYModel , NSCoding>


@property (nonatomic , copy) NSString *cover_image_url;

@property (nonatomic , copy) NSString *category;

//@property (nonatomic , copy) NSString *description;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , copy) NSString *subtitle;

@property (nonatomic , copy) NSString *banner_image_url;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , strong) NSNumber *post_published_at;

@property (nonatomic , copy) NSString *title;

//@property (nonatomic , strong) NSNumber *order;

//@property (nonatomic , strong) NSNumber *updated_at;


@end


//--------------------------------------------


@interface SZAuthorModel : NSObject<YYModel , NSCoding>

@property (nonatomic , copy) NSString *avatar_url;

@property (nonatomic , copy) NSString *nickname;

@end


//--------------------------------------------


@interface SZItemModel : NSObject<YYModel , NSCoding>


/**
 *  标记是哪一个栏目中的普通数据
 */
@property (nonatomic , assign) NSInteger columnNumber;



@property (nonatomic , strong) SZColumn *column;

//@property (nonatomic , copy) NSString *cover_webp_url;

//@property (nonatomic , strong) NSArray *labels;

@property (nonatomic , strong) NSNumber *liked;


//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *editor_id;

@property (nonatomic , copy) NSString *title;

//@property (nonatomic , strong) NSArray *ad_monitors;

@property (nonatomic , copy) NSString *url;

//@property (nonatomic , strong) NSNumber *published_at;

//@property (nonatomic , strong) NSNumber *updated_at;

//limit_end_at:(NULL)

//@property (nonatomic , copy) NSString *template;

//@property (nonatomic , assign) BOOL hidden_cover_image;

@property (nonatomic , strong) NSArray *feature_list;

//@property (nonatomic , copy) NSString *type;

@property (nonatomic , strong) NSNumber *post_id;

//@property (nonatomic , strong) NSNumber *content_type;

@property (nonatomic , copy) NSString *content_url;

@property (nonatomic , copy) NSString *share_msg;

@property (nonatomic , strong) NSNumber *likes_count;

@property (nonatomic , copy) NSString *introduction;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , copy) NSString *short_title;

/**
 *  作者信息
 */
@property (nonatomic , strong) SZAuthorModel *author;


//覆盖物图片URL
@property (nonatomic , copy) NSString *cover_image_url;

@end

//--------------------------------------------


@interface SZNormalCellModel : NSObject <YYModel>


@property (nonatomic , copy) NSArray *items;

@property (nonatomic , copy) NSDictionary *paging;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
