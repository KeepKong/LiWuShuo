//
//  SZColumnContentCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZColumnTableView.h"
#import "SZColumnModel.h"


@interface SZColumnContentCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SZColumnTableView *contentTableV;


//保存栏目信息数组
@property (nonatomic , copy) NSArray *columnArr;







//判断当前cell上的表视图属于哪一种栏目,从而在表视图中加载不同的栏目数据
@property (nonatomic , assign) NSInteger currentColumnIndex;



//如果这个cell是第一种类型，那么就调用这个方法去请求对应的第一个栏目的数据
- (void) loadFirstColumnData;



//-------------------------------------------------

//保存当前选中栏目模型，可以从中获取到栏目的id，用来请求数据
@property (nonatomic , strong) SZChannel *channelModel;

//保存其他栏目请求下来的数组
@property (nonatomic , copy) NSArray *normalModelArr;

/**
 *  网络加载动画的蒙版视图
 */
@property (nonatomic , strong) UIView *animationView;

/**
 *  蒙版视图上的动画view
 */
@property (nonatomic , strong) UIImageView *animationImageV;


//如果cell不是第一个栏目，那么就调用这个方法请求数据（除了第一个栏目的URL有区别之外，另外栏目的URL都是有规律的，可以通过拼接字符串得到）
- (void)loadNormalColumnData;

//添加网络加载的蒙版视图
- (void)addLoadAnimationView;


@end
