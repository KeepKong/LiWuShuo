//
//  SZCategoryDanPinCollVCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZLeftTabelV.h"
#import "SZRightTabelV.h"




@interface SZCategoryDanPinCollVCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet SZLeftTabelV *leftTableView;


@property (weak, nonatomic) IBOutlet SZRightTabelV *rightTableView;






- (void)loadDanPinData;




@end
