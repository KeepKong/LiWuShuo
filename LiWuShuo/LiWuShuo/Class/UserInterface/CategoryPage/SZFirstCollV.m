//
//  SZFirstCollV.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstCollV.h"
#import "SZFirstCollCell.h"
#import "SZLastCollViewCell.h"

@interface SZFirstCollV ()<UICollectionViewDataSource , UICollectionViewDelegate>

@end

static NSString *cellID = @"cell-ID";


@implementation SZFirstCollV


- (void)awakeFromNib
{

    self.delegate = self;
    self.dataSource = self;
    
    //设置流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(250 , 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    //这里的滑动方向决定着cell的布局方向，如果是水平滑动，那么cell布局的顺序就是从第一列向下开始，向右逐列布局，如果是垂直滑动，那么布局顺序就是从左到右，从上到下，
    //还有就是不同布局顺序情况下的minimumInteritemSpacing和minimumLineSpacing的意义是不一样的，如果是水平滑动，那么minimumInteritemSpacing表示的是上下两个cell的间距，如果这个按照这个间距布局之后，下面留下的距离不够再布局一个cell，那么这个间距就不起作用，直接将这个cell拉倒边缘，上下两个cell对其显示。
    //  其实不管滑动方向怎么变化，minimumInteritemSpacing总是表示按照特定的顺序布局，两个布局顺序相邻的cell之间的间距，minimumLineSpacing总是表示不同列或者不同行cell之间的间距。
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionViewLayout = flowLayout;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = YES;
    
    
    

//    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self registerNib:[UINib nibWithNibName:@"SZFirstCollCell" bundle:nil] forCellWithReuseIdentifier:@"firstCollCell"];
    
    [self registerNib:[UINib nibWithNibName:@"SZLastCollViewCell" bundle:nil] forCellWithReuseIdentifier:@"lastCell"];
    
    
}




- (void)setColumnsArr:(NSMutableArray *)columnsArr
{

    
    if (_columnsArr != columnsArr)
    {
        _columnsArr = columnsArr;
    }
    //创建一个空的，添加到数组中，最后一个设置为显示全部栏目按钮
    SZCategoryItemModel *model = [[SZCategoryItemModel alloc]init];
    
    [_columnsArr addObject:model];
    
    [self reloadData];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.columnsArr.count != 0)
    {
        
        return self.columnsArr.count;

    }
    else
    {
    
        return 0;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.item != self.columnsArr.count - 1)
    {
        
        SZFirstCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCollCell" forIndexPath:indexPath];
        
        
        cell.itemModel = self.columnsArr[indexPath.item];
        return cell;
        
    }
    else
    {
    
        
        SZLastCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lastCell" forIndexPath:indexPath];
        
        return cell;
        
        
    }
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
