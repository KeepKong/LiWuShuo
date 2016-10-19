//
//  SZCategoryColumnModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZCategoryItemModel : NSObject <YYModel>

//覆盖大图
@property (nonatomic , copy) NSString *cover_image_url;
/**
 *  栏目类型
 */
@property (nonatomic , copy) NSString *category;

/**
 *  简介
 */
//@property (nonatomic , copy) NSString *description;

//
//@property (nonatomic , copy) NSString *banner_webp_url;

//@property (nonatomic , strong) NSNumber *id;

/**
 *  作者的名字
 */
@property (nonatomic , copy) NSString *author;

/**
 *  //覆盖小图
 */
@property (nonatomic , copy) NSString *banner_image_url;

//@property (nonatomic , copy) NSString *cover_webp_url;

//@property (nonatomic , strong) NSNumber *created_at;

//@property (nonatomic , copy) NSString *subtitle;

//@property (nonatomic , strong) NSNumber *post_published_at;


/**
 *  标题
 */
@property (nonatomic , copy) NSString *title;


//@property (nonatomic , strong) NSNumber *order;

//@property (nonatomic , strong) NSNumber *updated_at;

//@property (nonatomic , strong) NSNumber *status;

@end



@interface SZCategoryColumnModel : NSObject<YYModel>

@property (nonatomic , copy) NSArray *columns;

@property (nonatomic , copy) NSDictionary *paging;



+ (instancetype)modelWithDictionary:(NSDictionary *)dict;



@end
