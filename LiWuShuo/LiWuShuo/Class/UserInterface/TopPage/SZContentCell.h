//
//  SZContentCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTopContentModel.h"


@interface SZContentCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@property (nonatomic , strong) SZTopItemModel *itemModel;



@end
