//
//  SZTopBGCollViewCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZBGContentCollV.h"
#import "SZTopColumnModel.h"

@interface SZTopBGCollViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SZBGContentCollV *contentCollV;

/**
 *  标记当前的cell是否已经进入网络请求，防止在collectionView代理方法的滑动已经结束的方法中再一次的调用请求网络的方法。这样没有意义，是多余的操作。
 *
 */
@property (nonatomic , assign) BOOL isRequest;




//当前需要加载的栏目模型，通过这个模型，拿到id，拼接成URL
@property (nonatomic , strong) SZRankModel *rankModel;

/**
 *  当前选中cell的栏目索引
 *
 */
@property (nonatomic , assign) NSInteger currentIndex;



/**
 *  网络加载动画的蒙版视图
 */
@property (nonatomic , strong) UIView *animationView;

/**
 *  蒙版视图上的动画view
 */
@property (nonatomic , strong) UIImageView *animationImageV;




//添加网络加载的蒙版视图
- (void)addLoadAnimationView;




- (void)loadTopColumnData;





@end
