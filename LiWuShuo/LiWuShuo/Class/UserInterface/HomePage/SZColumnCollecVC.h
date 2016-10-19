//
//  SZColumnCollecVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZColumnCollecVC : UICollectionViewController


+ (instancetype)defaultColumnCollecVC;




//保存栏目信息数组
@property (nonatomic , copy) NSArray *columnArr;


//当前选中的下标索引
@property (nonatomic , assign) NSInteger currentIndex;



@end
