//
//  SZDataBase.h
//  LiWuShuo
//
//  Created by lx on 16/10/11.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SZCycleModel.h"
#import "SZADModel.h"
#import "SZNormalCellModel.h"
#import "SZTopContentModel.h"


@interface SZDataBase : NSObject


+ (void)addFirstColumnCycleModel:(SZBannerModel *)model;

+ (void)addSecondModel:(SZSecondBanner *)model;

/**
 *  获取轮播模型数据
 */
+ (NSMutableArray *)gainCycleModel;
/**
 *  获取轮播下方模型数据
 */
+ (NSMutableArray *)gainSecondModels;

/**
 *  添加普通数据模型
 */
+ (void)addNormalModel:(SZItemModel *)model;

/**
 *  通过不同的栏目索引获取到对应的栏目模型数组
 */
+ (NSMutableArray *)gainNormalModelsWithColumnIndex:(NSInteger)index;

/**
 *  下拉刷新的时候，调用这个方法替换和删除掉数据库已经加载过的模型数据
 *
 */
+ (void)refreshCycleModelData:(NSMutableArray *)bannerModelsMuArr;
/**
 *  刷新轮播下方数据
 *
 */
+ (void)refreshSecondModelData:(NSMutableArray *)secondBannersMuArr;

/**
 *  刷新普通模型数据
 */
+ (void)refreshNormalModelData:(NSMutableArray *)normalModelsMuArr withIndex:(NSInteger)index;

/**
 *  删除表格中所有的缓存数据
 */
+ (void)removeHomePageAllColumnModel;

//-------------------------------------------------------
//-------------------------------------------------------
/**
 *  对榜单页面的操作
 */


+ (void)addTopOtherModel:(SZTopContentModel *)model;
+ (SZTopContentModel *)gainTopHeaderModelWithIndex:(NSInteger)index;
//刷新数据
+ (void)refreshTopPageData:(SZTopContentModel *)model WithIndex:(NSInteger)index;



+ (void)removeTopPageAllData;

@end
