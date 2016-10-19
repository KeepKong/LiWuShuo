//
//  SZColumnContentColleVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnContentColleVC.h"
#import "SZIndicatorView.h"
#import "UIView+Extention.h"
#import "SZColumnCollecVC.h"
#import "SZColumnCell.h"
#import "SZBGColumnCollVC.h"
#import "SZColumnContentCell.h"


@interface SZColumnContentColleVC ()

/**
 *  表示是否是点击了顶部栏目导致的切换栏目
 */
@property (nonatomic , assign) BOOL isTopColumnChange;



@end

@implementation SZColumnContentColleVC

static NSString * const reuseIdentifier = @"Cell";



- (instancetype)init
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(KScreenWidth , KScreenHeight - 64 - 35 - 49);
//    NSLog(@"bounds = %@" , NSStringFromCGSize(flowLayout.itemSize));

    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    if ([super initWithCollectionViewLayout:flowLayout])
    {
        
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 - 35 - 49);
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.bounces = NO;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    
    return self;
    
}

- (void)setColumnArr:(NSArray *)columnArr
{
    
    if (_columnArr != columnArr)
    {
        _columnArr = columnArr;
    }
    
    [self.collectionView reloadData];
    
}







- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.isTopColumnChange = NO;
    
    UINib *nib = [UINib nibWithNibName:@"SZColumnContentCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"columnContentCell"];
    
//    [self.collectionView registerClass:[SZColumnContentCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topColumnChange:) name:KTopColumnIndexChange object:nil];


}

#pragma  mark - 通知调用方法
- (void)topColumnChange:(NSNotification *)notification
{

    
    self.currentIndex = [notification.userInfo[@"index"] integerValue];
    
    if (self.currentIndex != 0)
    {
        
        self.isTopColumnChange = YES;
        

    }
    else
    {
        
        self.isTopColumnChange = NO;
    }

    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
    bgColumnCollVC.currentIndex = self.currentIndex;
    [bgColumnCollVC.collectionView reloadData];
    
}



- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.columnArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SZColumnContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"columnContentCell" forIndexPath:indexPath];
    
    
    if (indexPath.row == 0)
    {
        
        cell.currentColumnIndex = indexPath.row;
        cell.contentTableV.currentColumnIndex = indexPath.row;
        
        //这里和下面的网络加载数据同理。
//        [cell loadFirstColumnData];
        
        //在这里创建一个蒙版视图，添加上加载网络数据的动画
        [cell addLoadAnimationView];
        
        
        
        
    }
    else
    {
        
        cell.columnArr = self.columnArr;
        
        //这条语句一定要在上一条语句之前赋值，因为这条语句中需要用到columnArr
        cell.currentColumnIndex = indexPath.row;
        
        cell.contentTableV.currentColumnIndex = indexPath.row;
        
        
        //这里就不做立马加载了，先创建一个视图盖在另一个栏目的cell上，然后等滑动到了那个cell的时候，在这个视图上弄上一个加载的动画，等网络加载结束之后，将这个视图移除。
//        [cell loadNormalColumnData];
        
//        NSLog(@"加载cell");
        
        //在这里创建一个蒙版视图，添加上加载网络数据的动画
        [cell addLoadAnimationView];
    
 
        
    }
    
    /**
     *  判断是否是顶部栏目切换导致的加载cell，如果没有这个判断，会只有蒙版视图，没有动画视图，因为这个情况下，不会走scrollViewDidEndDecelerating:这个方法，所以必须手动调用。
     */
    if (self.isTopColumnChange)
    {
        
//        NSLog(@"top = %d" , self.isTopColumnChange);
        
        self.isTopColumnChange = NO;
        
        if (indexPath.row == 0)
        {
            [cell loadFirstColumnData];
        }
        else
        {
            
            [cell loadNormalColumnData];
        }
        
        
    }
    
    return cell;
    
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    CGFloat offsetIndex = scrollView.contentOffset.x/KScreenWidth;
    
    NSInteger currentIndex = (NSInteger)offsetIndex;
    
    
    self.currentIndex = currentIndex;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KAmongColumnIndexChange object:self userInfo:@{@"index" : @(currentIndex)}];
    
    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
    bgColumnCollVC.currentIndex = self.currentIndex;
    

    SZColumnContentCell *cell = (SZColumnContentCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]];
    
    //判断不同的栏目索引。调用不同的加载网络数据方法
    if (currentIndex == 0)
    {
        [cell loadFirstColumnData];

    }
    else
    {
        
        [cell loadNormalColumnData];
    }
    
    
    
//    NSLog(@"开始加载动画");
    
    
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
