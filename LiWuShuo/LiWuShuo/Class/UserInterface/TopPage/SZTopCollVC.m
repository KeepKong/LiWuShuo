//
//  SZTopCollVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopCollVC.h"

#import "SZTopCollVCell.h"
#import "SZTopIndicatorView.h"
#import "UIView+Extention.h"


@interface SZTopCollVC ()

@end

@implementation SZTopCollVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumInteritemSpacing = 10.0;
    flowLayout.minimumLineSpacing = 10.0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if (self = [super initWithCollectionViewLayout:flowLayout])
    {
        
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, 30);
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.bounces = NO;

        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    
    return self;
    
}


- (void)setTopColumnArr:(NSArray *)topColumnArr
{

    if (_topColumnArr != topColumnArr)
    {
        _topColumnArr = topColumnArr;
    }
    
    [self.collectionView reloadData];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    self.collectionView.bounces = NO;
    
    
    
    [self.collectionView registerClass:[SZTopCollVCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //注册成为中间内容索引改变的通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topPageAmongColumnIndexChange:) name:KTopPageAmongColumnIndexChange object:nil];
    
    
}

- (void)topPageAmongColumnIndexChange:(NSNotification *)notification
{

    NSInteger index = [notification.userInfo[@"index"] integerValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    self.currentIndex = indexPath.row;
    
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self performSelector:@selector(moveIndicatorView) withObject:nil afterDelay:0.3];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.topColumnArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SZTopCollVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.rankModel = self.topColumnArr[indexPath.item];
    
    if (indexPath.row == self.currentIndex)
    {
        
        
        cell.columnLabel.textColor = [UIColor redColor];
        
    }
    else
    {
        
        cell.columnLabel.textColor = [UIColor grayColor];
    }
    
    
    
    return cell;
}

- (void)moveIndicatorView
{
    
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.currentIndex = indexPath.row;
    
    
    [self.collectionView reloadData];
    
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self performSelector:@selector(moveIndicatorView) withObject:nil afterDelay:0.3];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTopPageTopColumnIndexChange object:self userInfo:@{@"index" : @(indexPath.row)}];
    
    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
//    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
//    bgColumnCollVC.currentIndex = self.currentIndex;
//    [bgColumnCollVC.collectionView reloadData];
    
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    
    [self.collectionView performBatchUpdates:^{
        
        
    } completion:^(BOOL finished) {
        
        
        SZTopCollVCell *cell = (SZTopCollVCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        
        SZTopIndicatorView *indicatorView = [SZTopIndicatorView defaultTopIndicatiorView];
        
        
        
        CGRect actual_rect = [self.collectionView convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            indicatorView.x = actual_rect.origin.x;
            
        }];

    }];
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
