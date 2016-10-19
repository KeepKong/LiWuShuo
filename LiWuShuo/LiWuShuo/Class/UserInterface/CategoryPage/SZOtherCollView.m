//
//  SZOtherCollView.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZOtherCollView.h"
#import "SZOtherCell.h"



@interface SZOtherCollView ()<UICollectionViewDataSource , UICollectionViewDelegate>

@end


@implementation SZOtherCollView


- (void)awakeFromNib
{

    self.delegate = self;
    self.dataSource = self;
    
    //设置流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat width = (KScreenWidth - 40)/2.0;
    
    
    flowLayout.itemSize = CGSizeMake(width , 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;

    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    
    self.collectionViewLayout = flowLayout;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = YES;
    
//    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self registerNib:[UINib nibWithNibName:@"SZOtherCell" bundle:nil] forCellWithReuseIdentifier:@"otherCell"];
    
    
    
}


- (void)setChannelsArr:(NSMutableArray *)channelsArr
{

    if (_channelsArr != channelsArr)
    {
        _channelsArr = channelsArr;
    }
    
    
    [self reloadData];
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    

        
    return 6;

    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    SZOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherCell" forIndexPath:indexPath];
    
    SZCategoryChannelItemModel *model = self.channelsArr[indexPath.item];
    
    
    cell.urlStr = model.cover_image_url;
//    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;

    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
