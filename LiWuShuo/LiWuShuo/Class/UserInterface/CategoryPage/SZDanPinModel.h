//
//  SZDanPinModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>


@interface SZSubcategorieModel : NSObject<YYModel>


//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , strong) NSNumber *items_count;

@property (nonatomic , strong) NSNumber *order;

@property (nonatomic , copy) NSString *icon_url;

//@property (nonatomic , strong) NSNumber *parent_id;

@property (nonatomic , copy) NSString *name;

@end




@interface SZDanPinCategorieModel : NSObject<YYModel>


//@property (nonatomic , strong) NSNumber *status;

//@property (nonatomic , strong) NSNumber *id;

@property (nonatomic , copy) NSString *icon_url;

//@property (nonatomic , strong) NSNumber *order;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , strong) NSArray *subcategories;

@property (nonatomic , strong) NSNumber *rowHeight;



@end


@interface SZDanPinModel : NSObject<YYModel>

@property (nonatomic , strong) NSArray *categories;




+ (instancetype)modelWithDictionary:(NSDictionary *)dict;



@end
