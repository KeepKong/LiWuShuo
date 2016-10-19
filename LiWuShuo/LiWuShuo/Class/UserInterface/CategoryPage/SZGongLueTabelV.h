//
//  SZGongLueTabelV.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCategoryColumnModel.h"
#import "SZChannelGroupModel.h"


@interface SZGongLueTabelV : UITableView

/**
 *  第一个cell的模型
 */
@property (nonatomic , strong) SZCategoryColumnModel *columnModel;

/**
 *  其余cell的模型
 */
@property (nonatomic , strong) SZChannelGroupModel *groupModel;


@end
