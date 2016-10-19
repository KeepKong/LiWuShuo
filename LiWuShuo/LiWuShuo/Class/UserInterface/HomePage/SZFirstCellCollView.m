//
//  SZFirstCellCollView.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstCellCollView.h"
#import "SZFirstCellCollCell.h"



@interface SZFirstCellCollView ()<UICollectionViewDataSource , UICollectionViewDelegate>

@end


static NSString *const cellID = @"cellID";


@implementation SZFirstCellCollView




- (void)awakeFromNib
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60, 60);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    self.collectionViewLayout = flowLayout;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    [self registerClass:[SZFirstCellCollCell class] forCellWithReuseIdentifier:cellID];
    
}

- (void)setSecondModelArr:(NSArray *)secondModelArr
{

    if (_secondModelArr != secondModelArr)
    {
        _secondModelArr = secondModelArr;
    }
    
    [self reloadData];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.secondModelArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SZFirstCellCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor orangeColor];
    cell.secondModel = self.secondModelArr[indexPath.item];
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
