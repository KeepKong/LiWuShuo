//
//  SZColumnTableView.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCycleModel.h"
#import "SZColumnModel.h"

//@protocol SZPushCellDetailPageDelegate <NSObject>
//
//
//- (void)pushCellDetailPageDelegate;
//
//@end

@interface SZColumnTableView : UITableView


///**
// *  设置push到cell详情页面的代理
// */
//
//@property (nonatomic , weak) id<SZPushCellDetailPageDelegate> pushDelegate;



//判断当前cell上的表视图属于哪一种栏目,从而在表视图中加载不同的栏目数据
@property (nonatomic , assign) NSInteger currentColumnIndex;


//表示当前栏目上拉加载URL中，礼物数据的偏移量
@property (nonatomic , assign) NSInteger offset;




//-----------------------第一个栏目的模型数据-----------------

//保存第一个栏目中的轮播数据模型
@property (nonatomic , copy) NSArray *cycleModelArr;

/**
 *  保存栏目轮播下方的展示视图模型数组
 */
@property (nonatomic , copy) NSArray *secondBannerModelArr;

/**
 *  保存栏目中礼物信息模型数据的数组
 */
@property (nonatomic , strong) NSMutableArray *giftModelArr;



//----------------------其他栏目的模型数据--------------------
//保存其他栏目的礼物模型
@property (nonatomic , strong) NSMutableArray *normalModelArr;


//保存当前选中栏目模型，可以从中获取到栏目的id，用来请求数据
@property (nonatomic , strong) SZChannel *channelModel;

@end
