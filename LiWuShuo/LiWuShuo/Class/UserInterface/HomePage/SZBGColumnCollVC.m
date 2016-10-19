//
//  SZBGColumnCollVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZBGColumnCollVC.h"
#import "SZColumnModel.h"
#import "SZBGCell.h"


@interface SZBGColumnCollVC ()

@end

//用来记录补充的cell个数
NSInteger temp = 0;
//对temp起到标记作用，不让栏目数组一直加上temp数量
BOOL flag = NO;

@implementation SZBGColumnCollVC

static NSString * const reuseIdentifier = @"Cell";

+ (instancetype)defaultBGColumnCollVC
{
    
    static SZBGColumnCollVC *columnCollVC;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        columnCollVC = [SZBGColumnCollVC alloc];
        
    });
    
    
    return columnCollVC;
}


- (instancetype)init
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((KScreenWidth - 5)/4, 40);
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.minimumLineSpacing = 1.0;
    
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if (self = [super initWithCollectionViewLayout:flowLayout])
    {
        
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, 160);
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.bounces = NO;
    
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    
    [self.collectionView registerClass:[SZBGCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
}


- (void)setColumnArr:(NSMutableArray *)columnArr
{
    
    if (_columnArr != columnArr)
    {
        _columnArr = columnArr;
    }
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    NSInteger row = (NSInteger)columnArr.count / 4;

    if (columnArr.count % 4 != 0)
    {
        
        row++;
    }

    CGFloat height = (CGFloat)(160.0 - (row+1))/(CGFloat)row;
    
    flowLayout.itemSize = CGSizeMake((KScreenWidth - 5)/4, height);
    
    [self.collectionView reloadData];
    
    
    

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

//    NSLog(@"coutn =%ld" , self.columnArr.count);
    
    temp = (self.columnArr.count - temp) % 4;
    
    if (temp != 0 && flag == NO)
    {
        
        for (int i = 0; i < temp; i++)
        {
            
            SZChannel *model = [[SZChannel alloc] init];
            
            [self.columnArr addObject:model];
        }
        
        flag = YES;
        
        return self.columnArr.count + temp;

    }
    else
    {
    
        return self.columnArr.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SZBGCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.channel = self.columnArr[indexPath.row];

    if (indexPath.row == self.currentIndex)
    {
        cell.indicatorView.hidden = NO;
        cell.label.textColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
    }
    else
    {
    
        cell.indicatorView.hidden = YES;
        cell.label.textColor = [UIColor darkGrayColor];
    }
    
    
    
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"将要选中%ld个" , indexPath.row);
    return YES;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    self.currentIndex = indexPath.row;
//    NSLog(@"index.row = %ld" , indexPath.row);
//    NSLog(@"count = %ld" , self.columnArr.count);
//    NSLog(@"temp = %ld" , temp);
    if (indexPath.row < self.columnArr.count-temp)
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KTopColumnIndexChange object:self userInfo:@{@"index" : @(indexPath.row)}];
        
        [[NSNotificationCenter defaultCenter] postNotificationName: KAmongColumnIndexChange object:self userInfo:@{@"index" : @(indexPath.row)}];

    }
    
    
    
    
    
    
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
