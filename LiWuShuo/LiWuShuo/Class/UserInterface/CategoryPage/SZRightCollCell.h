//
//  SZRightCollCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZDanPinModel.h"
@interface SZRightCollCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *giftImageV;
@property (weak, nonatomic) IBOutlet UILabel *giftNameLabel;




@property (nonatomic , strong) SZSubcategorieModel *model;


@end
