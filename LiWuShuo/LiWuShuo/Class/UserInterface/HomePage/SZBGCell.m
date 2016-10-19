//
//  SZBGCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZBGCell.h"

@implementation SZBGCell


- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.textColor = [UIColor darkGrayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.label];
        
        
        
        self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 3, frame.size.width, 3)];
        self.indicatorView.backgroundColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
        self.indicatorView.hidden = YES;
        
        [self.contentView addSubview: self.indicatorView];
        
    }
    
    return self;
    
}

- (void)setChannel:(SZChannel *)channel
{

    self.label.text = channel.name;
    
}



@end
