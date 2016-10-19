//
//  SZCategoryBgCollVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/7.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCategoryBgCollVC.h"
#import "SZCategoryDanPinCollVCell.h"
#import "SZCategoryColleVCell.h"
#import "SZTitleView.h"




@interface SZCategoryBgCollVC ()





@end

@implementation SZCategoryBgCollVC

//static NSString * const reuseIdentifier = @"Cell";


- (instancetype)init
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //50是上方搜索栏预留的高度，这个高度系统自己定义的，50比较合适
    flowLayout.itemSize = CGSizeMake(KScreenWidth , KScreenHeight - 64 - 50 - 49);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    if ([super initWithCollectionViewLayout:flowLayout])
    {
        

        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 - 50 - 49);
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.bounces = NO;
        
        
    }
    
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SZCategoryCollVCell" bundle:nil] forCellWithReuseIdentifier:@"gongLueCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SZDanPinCollCell" bundle:nil] forCellWithReuseIdentifier:@"danPinCell"];
    
    
    // Do any additional setup after loading the view.
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

    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *resueID = @"";

    
    if (indexPath.row == 0)
    {

        
        resueID = @"gongLueCell";
        
        
    }
    else
    {
        
        resueID = @"danPinCell";
        

    }
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resueID forIndexPath:indexPath];
    
    
    if ([resueID isEqualToString:@"gongLueCell"])
    {
        
        SZCategoryColleVCell *gongLueCell = (SZCategoryColleVCell *)cell;
        
        [gongLueCell loadNetworkingColumnData];
        

        
        
        return gongLueCell;
    }
    else
    {
    
        SZCategoryDanPinCollVCell *danPinCell = (SZCategoryDanPinCollVCell *)cell;
        
        
        [danPinCell loadDanPinData];
        
        
        return danPinCell;
        
        
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    SZTitleView *titleView = [SZTitleView getIndicatorView];
    
    NSInteger itemCount = scrollView.contentOffset.x/KScreenWidth;
    UIView *indicatorView = titleView.indicatorView;
    
//    NSLog(@"indicatorView = %@" , self.navigationController.navigationItem.titleView);
    
    static NSInteger origainIndex = 0;
    
    if (itemCount != origainIndex)
    {
        
        
        NSInteger flag = 1;
        if (itemCount > origainIndex)
        {
            flag = 1;
            
            titleView.gongLueBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            titleView.danPinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            
            
        }
        else
        {
            
            flag = -1;
            
            titleView.gongLueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            titleView.danPinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            
            
        }
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            indicatorView.transform = CGAffineTransformTranslate(indicatorView.transform, flag * (40 + 30), 0);
            
            
        }];
        
        
        origainIndex = itemCount;

        
    }
    

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{


    return NO;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"选中了%ld" , indexPath.item);
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
