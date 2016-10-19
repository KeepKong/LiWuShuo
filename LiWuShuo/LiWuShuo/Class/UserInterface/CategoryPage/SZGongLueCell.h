//
//  SZGongLueCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCategoryColumnModel.h"
#import "SZFirstCollV.h"



@interface SZGongLueCell : UITableViewCell


@property (weak, nonatomic) IBOutlet SZFirstCollV *firstCollView;


@property (nonatomic , strong) SZCategoryColumnModel *columnModel;




@end
