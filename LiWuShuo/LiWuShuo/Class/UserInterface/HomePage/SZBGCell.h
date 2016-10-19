//
//  SZBGCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZColumnModel.h"




@interface SZBGCell : UICollectionViewCell


@property (nonatomic , strong) UIView *indicatorView;


@property (nonatomic , strong) UILabel *label;




@property (nonatomic , strong) SZChannel *channel;


@end
