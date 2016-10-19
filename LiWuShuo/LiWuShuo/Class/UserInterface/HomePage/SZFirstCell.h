//
//  SZfirstCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZFirstCellCollView.h"
#import "SZCycleModel.h"



@interface SZFirstCell : UITableViewCell

//保存轮播数据的数组
@property (nonatomic , strong) NSMutableArray *bannerMuArr;



@property (weak, nonatomic) IBOutlet UIView *cycleBgView;
@property (weak, nonatomic) IBOutlet SZFirstCellCollView *secondCollView;




/**
 *  保存轮播URL数组
 */
@property (nonatomic , copy) NSArray *cycleImageURLArr;

/**
 *  保存轮播下方的模型的数组
 */
@property (nonatomic , copy) NSArray *secondModelArr;



@end
