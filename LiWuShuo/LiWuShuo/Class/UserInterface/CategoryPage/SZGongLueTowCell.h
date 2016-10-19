//
//  SZGongLueTowCell.h
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZOtherCollView.h"

#import "SZChannelGroupModel.h"


@interface SZGongLueTowCell : UITableViewCell


@property (weak, nonatomic) IBOutlet SZOtherCollView *otherCollView;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;





/**
 *  保存other栏目的模型
 */
@property (nonatomic , strong) SZCategoryChannelModel *channelModel;



@end
