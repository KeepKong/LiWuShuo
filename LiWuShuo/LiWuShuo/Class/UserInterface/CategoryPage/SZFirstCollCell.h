//
//  SZFirstCollCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCategoryColumnModel.h"


@interface SZFirstCollCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *columnImageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;



@property (nonatomic , strong) SZCategoryItemModel *itemModel;



@end
