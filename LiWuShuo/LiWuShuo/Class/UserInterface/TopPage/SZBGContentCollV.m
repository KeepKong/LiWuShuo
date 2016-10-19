//
//  SZBGContentCollV.m
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZBGContentCollV.h"
#import "SZCollReusableView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SZTopContentModel.h"
#import "SZContentCell.h"
#import <MJRefresh/MJRefresh.h>
#import "SZNetWorkingTool.h"
#import "SZDataBase.h"



#define KCellID @"CellID"


@interface SZBGContentCollV ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>


@property (nonatomic , assign) BOOL isDownOrUpRefresh;





@end


@implementation SZBGContentCollV

- (void)awakeFromNib
{

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    CGFloat width = (KScreenWidth - 35)/2.0;
    CGFloat height = 250;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 0, 10);
    flowLayout.minimumInteritemSpacing = 15.0;
    flowLayout.minimumLineSpacing = 15.0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.collectionViewLayout = flowLayout;

    self.delegate = self;
    
    self.dataSource = self;
    
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

    
    [self registerNib:[UINib nibWithNibName:@"SZContentCell" bundle:nil] forCellWithReuseIdentifier:@"contentCell"];
    
    [self registerNib:[UINib nibWithNibName:@"SZCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    
    //添加刷新头视图
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downUpdateAction)];
    
    
}


#pragma mark - 头视图刷新
- (void)downUpdateAction
{

//    NSLog(@"下拉刷新！！");
    self.isDownOrUpRefresh = YES;
    
    [self loadTopColumnData];
    
}


#pragma mark - 下拉刷新网络数据
- (void)loadTopColumnData
{
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    NSString *urlStr = [NSString stringWithFormat:@"ranks_v2/ranks/%ld?limit=20&offset=0" , [self.rankModel.top_Column_id integerValue]];
    
    //    NSLog(@"urlStr =%@" , urlStr);
    //    NSString *urlStr = @"ranks/1?limit=20&offset=0";
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //        NSLog(@"dict = %@" , dict);
        //        [dict[@"data"][@"items"][0] generatePropertyCodes];
        SZTopContentModel *model = [SZTopContentModel modelWithDictionary:dict[@"data"]];
        
        self.contentModel = model;
        
        //结束下拉刷新
        if (self.isDownOrUpRefresh)
        {
            
            self.isDownOrUpRefresh = NO;
            
            [self.mj_header endRefreshing];
            /**
             *  刷新数据库中存放的数据
             */

            [SZDataBase refreshTopPageData:model WithIndex:[self.rankModel.top_Column_id integerValue]-1];
            

        }
        else
        {
        
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败!!");
        
    }];
}



#pragma mark - setter

- (void)setContentModel:(SZTopContentModel *)contentModel
{

    if (_contentModel != contentModel)
    {
        _contentModel = contentModel;
    }
    
    [self reloadData];
    
    
}





- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{


    return self.contentModel.items.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    SZContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 5;
    
    
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.itemModel = self.contentModel.items[indexPath.row];
    
    
    
    return cell;
}

//组头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    
    SZCollReusableView *view = (SZCollReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
//    SZTopItemModel *model = self.itemsArr[indexPath.item];
    
    
    
    [view.imgView sd_setImageWithURL:[NSURL URLWithString:self.contentModel.cover_image]];
    
    return view;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"选中了%ld" , indexPath.item);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(KScreenWidth, 200);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
