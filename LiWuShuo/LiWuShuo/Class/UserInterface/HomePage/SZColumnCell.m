//
//  SZColumnCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnCell.h"

@interface SZColumnCell ()



@end


@implementation SZColumnCell


- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        self.textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.text = @"精选";
        
        
        [self.contentView addSubview:self.textLabel];
        
    }
    
    return self;
}


- (void)setModel:(SZChannel *)model
{

    self.textLabel.text = model.name;
    
    
}


@end
