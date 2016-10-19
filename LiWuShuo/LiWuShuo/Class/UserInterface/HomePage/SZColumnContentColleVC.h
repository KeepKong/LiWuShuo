//
//  SZColumnContentColleVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZColumnModel.h"



@interface SZColumnContentColleVC : UICollectionViewController


//当前选中的下标索引
@property (nonatomic , assign) NSInteger currentIndex;

//保存栏目信息数组
@property (nonatomic , copy) NSArray *columnArr;


@end
