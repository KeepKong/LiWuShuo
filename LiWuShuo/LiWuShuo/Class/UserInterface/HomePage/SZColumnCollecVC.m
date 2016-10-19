//
//  SZColumnCollecVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnCollecVC.h"
#import "SZColumnCell.h"
#import "UIView+Extention.h"
#import "SZIndicatorView.h"
#import "SZBGColumnCollVC.h"


#define reuseIdentifier @"Cell"


@interface SZColumnCollecVC ()





@end

@implementation SZColumnCollecVC






+ (instancetype)defaultColumnCollecVC
{

    static SZColumnCollecVC *columnCollecVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        columnCollecVC = [SZColumnCollecVC alloc];
        
    });
    
    
    return columnCollecVC;
}



- (instancetype)init
{

    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumInteritemSpacing = 10.0;
    flowLayout.minimumLineSpacing = 10.0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    if (self = [super initWithCollectionViewLayout:flowLayout])
    {
        
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth-30, 30);
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.bounces = NO;
//        self.collectionView.pagingEnabled = YES;
        
        
        
        
        
    }
    
    
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.currentIndex = 0;
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    // Register cell classes
    [self.collectionView registerClass:[SZColumnCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amongContentIndexChange:) name:KAmongColumnIndexChange object:nil];
    
    
}





- (void)setColumnArr:(NSArray *)columnArr
{

    if (_columnArr != columnArr)
    {
        _columnArr = columnArr;
    }
    
    [self.collectionView reloadData];
    
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"选中第%ld个" , indexPath.row);
    
    self.currentIndex = indexPath.row;
    
    
    [self.collectionView reloadData];

    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self performSelector:@selector(moveIndicatorView) withObject:nil afterDelay:0.3];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTopColumnIndexChange object:self userInfo:@{@"index" : @(indexPath.row)}];
    
    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
    bgColumnCollVC.currentIndex = self.currentIndex;
    [bgColumnCollVC.collectionView reloadData];
    

    
}

- (void)moveIndicatorView
{

    [self scrollViewDidEndScrollingAnimation:self.collectionView];

}





- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通知调用方法
- (void)amongContentIndexChange:(NSNotification *)notification
{
    
    NSInteger index = [notification.userInfo[@"index"] integerValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    self.currentIndex = indexPath.row;
    
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    [self performSelector:@selector(moveIndicatorView) withObject:nil afterDelay:0.3];
    
    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
    bgColumnCollVC.currentIndex = self.currentIndex;
    [bgColumnCollVC.collectionView reloadData];
    

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{


    
    SZColumnCollecVC *columnCollecVC = [SZColumnCollecVC defaultColumnCollecVC];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];

    
    [self.collectionView performBatchUpdates:^{
        
        
    } completion:^(BOOL finished) {
        
        
        SZColumnCell *cell = (SZColumnCell *)[columnCollecVC.collectionView cellForItemAtIndexPath:indexPath];
        
        
        SZIndicatorView *indicatorView = [SZIndicatorView defaultIndicatiorView];
        
        
        CGRect actual_rect = [self.collectionView convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];

        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            indicatorView.x = actual_rect.origin.x;
            
        }];
        
        
        
        
        
    }];
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

    
    
    return self.columnArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SZColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    SZChannel *model = self.columnArr[indexPath.row];
    
    cell.model = model;

    if (indexPath.row == self.currentIndex)
    {
        
        
        cell.textLabel.textColor = [UIColor redColor];
        
    }
    else
    {
    
        cell.textLabel.textColor = [UIColor grayColor];
    }
    
    
    
    
    return cell;
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
