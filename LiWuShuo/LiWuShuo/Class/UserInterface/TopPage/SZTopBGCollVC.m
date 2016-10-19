//
//  SZTopBGCollVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopBGCollVC.h"
#import "SZTopBGCollViewCell.h"




@interface SZTopBGCollVC ()


/**
 *  判断是否是点击顶部栏目，导致的刷新内容视图
 */
@property (nonatomic , assign) BOOL isTopColumnChange;




@end

@implementation SZTopBGCollVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(KScreenWidth , KScreenHeight - 64 - 35 - 49);
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
    self.isTopColumnChange = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SZTopBGCollCell" bundle:nil] forCellWithReuseIdentifier:@"topBGCollCell"];

    
    //注册成为顶部栏目索引变化的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topPageTopColumnIndexChange:) name:KTopPageTopColumnIndexChange object:nil];
    
    

}

#pragma mark - 通知调用方法
- (void)topPageTopColumnIndexChange:(NSNotification *)notification
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
    
    
    SZTopBGCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topBGCollCell" forIndexPath:indexPath];
    
    cell.rankModel = self.topColumnArr[indexPath.row];
    //设置cell上的集合视图当前栏目模型，给下拉刷新中URL中的id使用
    cell.contentCollV.rankModel = cell.rankModel;
    
    cell.currentIndex = indexPath.item;
    
    //同首页请求页面的效果相同，先加蒙版视图，给个动画，用户体验更好。
//    [cell loadTopColumnData];
    
    [cell addLoadAnimationView];
    
    
    //如果是第一个接收到通知，加载cell的话，因为已经在addLoadAnimationView这个方法中调用了loadTopColumnData方法，所以这里可以不用再次调用了。
    if (self.isTopColumnChange)
    {
        
        self.isTopColumnChange = NO;
        [cell loadTopColumnData];
    }
    
    
    //在复用的情况下，将cell移动到顶部，显示效果更加的好一些
    [cell.contentCollV setContentOffset:CGPointMake(0, 0) animated:NO];
    
    
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat offsetIndex = scrollView.contentOffset.x/KScreenWidth;
    
    NSInteger currentIndex = (NSInteger)offsetIndex;
    
    
    self.currentIndex = currentIndex;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTopPageAmongColumnIndexChange object:self userInfo:@{@"index" : @(currentIndex)}];
    
    
//    NSLog(@"切换了item");
//    //拿到背后隐藏的所有栏目集合视图，改变选中的视图
//    SZBGColumnCollVC *bgColumnCollVC = [SZBGColumnCollVC defaultBGColumnCollVC];
//    bgColumnCollVC.currentIndex = self.currentIndex;
    
    
    //拿到对应的cell，然后对cell请求网络数据
    SZTopBGCollViewCell *cell = (SZTopBGCollViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    
    if (!cell.isRequest)
    {
        [cell loadTopColumnData];

    }
    
    
    
}


- (void)dealloc
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
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
