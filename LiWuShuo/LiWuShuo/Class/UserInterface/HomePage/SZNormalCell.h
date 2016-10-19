//
//  SZNormalCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZNormalCellModel.h"


@interface SZNormalCell : UITableViewCell






@property (weak, nonatomic) IBOutlet UILabel *typeLable;



@property (weak, nonatomic) IBOutlet UIView *typeBgView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeViewWidth;





@property (weak, nonatomic) IBOutlet UILabel *columnTitle;

@property (weak, nonatomic) IBOutlet UIImageView *userImageV;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageV;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;




/**
 *  保存栏目中礼物信息模型数据的数组
 */
@property (nonatomic , strong) SZItemModel *itemModel;











@end
