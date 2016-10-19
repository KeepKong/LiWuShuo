//
//  SZLeftTabelV.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZLeftTabelV.h"
#import "SZLeftCell.h"



@interface SZLeftTabelV ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , assign) NSInteger currentIndex;



@end


@implementation SZLeftTabelV


- (void)awakeFromNib
{

    self.currentIndex = 0;
    
    
    self.delegate = self;
    self.dataSource = self;

    [self registerNib:[UINib nibWithNibName:@"SZLeftCell" bundle:nil] forCellReuseIdentifier:@"leftCell"];
    
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    
    
    //注册成为右边表视图栏目切换的通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryRightIndexChange:) name:KCategoryRightIndexChange object:nil];

}



- (void)setLeftModel:(SZDanPinModel *)leftModel
{

    if (_leftModel != leftModel)
    {
        _leftModel = leftModel;
    }
    
    
    [self reloadData];
}

#pragma mark - 通知响应方法
- (void)categoryRightIndexChange:(NSNotification *)notification
{

    self.currentIndex = [notification.userInfo[@"currentIndex"] integerValue];
    
    NSLog(@"leftCurrent = %ld" , self.currentIndex);
    
    [self reloadData];
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
}



#pragma mark - TabelView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.leftModel.categories.count;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SZLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    
    
    SZDanPinCategorieModel *model = self.leftModel.categories[indexPath.row];
    cell.categoryLabel.text = model.name;
    
    
    if (self.currentIndex == indexPath.row)
    {
        cell.indicatorView.hidden = NO;
        cell.backgroundColor = [UIColor whiteColor];
        cell.categoryLabel.textColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
        
        
    }
    else
    {
    
        cell.indicatorView.hidden = YES;
        cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        cell.categoryLabel.textColor = [UIColor darkGrayColor];
        
    }
    
    
    
    

    
    return cell;
    
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentIndex = indexPath.row;
    
    [self reloadData];
    

    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

    
    //发送改变索引的通知，给左边的表视图
    [[NSNotificationCenter defaultCenter] postNotificationName:KCategoryLeftIndexChange
    object:self
    userInfo:@{
               
               @"currentIndex" : @(self.currentIndex)
               
               }];
    
    
    return NO;

}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
