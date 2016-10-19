//
//  SZCategoryColleVCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZGongLueTabelV.h"



@interface SZCategoryColleVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SZGongLueTabelV *contentTableView;


- (void)loadNetworkingColumnData;






@end
