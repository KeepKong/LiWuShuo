//
//  SZTopCollVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTopCollVC : UICollectionViewController


//当前选中的下标索引
@property (nonatomic , assign) NSInteger currentIndex;



/**
 *  保存栏目数据
 */
@property (nonatomic , copy) NSArray *topColumnArr;



@end
