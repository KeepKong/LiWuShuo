//
//  SZDetailCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCycleDetailModel.h"




@interface SZDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@property (weak, nonatomic) IBOutlet UILabel *columnTitleLabel;


@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;




@property (nonatomic , strong) SZPostModel *postModel;



@end
