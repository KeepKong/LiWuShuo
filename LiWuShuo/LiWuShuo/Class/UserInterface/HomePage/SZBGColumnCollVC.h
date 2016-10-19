//
//  SZBGColumnCollVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZBGColumnCollVC : UICollectionViewController

//保存栏目信息数组
@property (nonatomic , strong) NSMutableArray *columnArr;


//当前选中的下标索引
@property (nonatomic , assign) NSInteger currentIndex;



+ (instancetype)defaultBGColumnCollVC;



@end
