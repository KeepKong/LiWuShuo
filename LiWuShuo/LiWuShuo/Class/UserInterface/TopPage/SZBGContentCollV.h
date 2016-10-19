//
//  SZBGContentCollV.h
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTopContentModel.h"
#import "SZTopColumnModel.h"

@interface SZBGContentCollV : UICollectionView


/**
 *  保存集合视图内容数据模型的数组
 */

@property (nonatomic , strong) SZTopContentModel *contentModel;






/**
 *  保存集合视图当前栏目模型，使用其中的id，在下拉刷新的时候起作用
 */

@property (nonatomic , strong) SZRankModel *rankModel;

@end
