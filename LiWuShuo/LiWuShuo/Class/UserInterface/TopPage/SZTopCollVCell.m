//
//  SZTopCollVCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopCollVCell.h"

@interface SZTopCollVCell ()



@end


@implementation SZTopCollVCell

- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.columnLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.columnLabel.textAlignment = NSTextAlignmentCenter;
        self.columnLabel.textColor = [UIColor darkGrayColor];
        self.columnLabel.font = [UIFont systemFontOfSize:15];
        self.columnLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.columnLabel];
    }
    
    return self;
}


- (void)setRankModel:(SZRankModel *)rankModel
{

    
    if (_rankModel != rankModel)
    {
        _rankModel = rankModel;
    }
    
    
    self.columnLabel.text = rankModel.name;
    
    
    
}


@end
