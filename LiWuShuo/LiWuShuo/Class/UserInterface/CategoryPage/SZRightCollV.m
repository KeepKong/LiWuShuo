//
//  SZRightCollV.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZRightCollV.h"
#import "SZRightCollCell.h"

@interface SZRightCollV ()<UICollectionViewDataSource , UICollectionViewDelegate>




@end


@implementation SZRightCollV

- (void)awakeFromNib
{

    self.delegate = self;
    self.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(80, 120);
    flowLayout.minimumInteritemSpacing = 7;
    flowLayout.minimumLineSpacing = 7;
    flowLayout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.collectionViewLayout = flowLayout;
    
    
    
//    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self registerNib:[UINib nibWithNibName:@"SZRightCollCell" bundle:nil] forCellWithReuseIdentifier:@"rightCollCell"];
    
    
//    self.scrollEnabled = NO;
    
}


- (void)setSubCategoryMuArr:(NSMutableArray *)subCategoryMuArr
{

    if (_subCategoryMuArr != subCategoryMuArr)
    {
        _subCategoryMuArr = subCategoryMuArr;
    }
    
    
    [self reloadData];

}


#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.subCategoryMuArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    SZRightCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightCollCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor purpleColor];
    
    SZSubcategorieModel *model = self.subCategoryMuArr[indexPath.row];
    
    cell.model = model;
    
    
    
    return cell;
    
    
    
    
}




@end
