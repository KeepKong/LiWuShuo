//
//  SZCycleDetailTableVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCycleDetailTableVC : UITableViewController


@property (nonatomic , strong) NSNumber *request_id;


//保存模型数据的数组
@property (nonatomic , strong) NSMutableArray *postModelMuArr;


@end
