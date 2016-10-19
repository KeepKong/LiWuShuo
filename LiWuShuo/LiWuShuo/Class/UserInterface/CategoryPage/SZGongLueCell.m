//
//  SZGongLueCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZGongLueCell.h"

@implementation SZGongLueCell



- (void)setColumnModel:(SZCategoryColumnModel *)columnModel
{

    if (_columnModel != columnModel)
    {
        _columnModel = columnModel;
    }
    

    //cell上获取到数据，马上将数据交给cell上的集合视图，用于显示数据，然后刷新集合视图。
    self.firstCollView.columnsArr = [columnModel.columns mutableCopy];
    
    
    
    [self.firstCollView reloadData];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
