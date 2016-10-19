//
//  SZColumnTableView.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnTableView.h"
#import "SZfirstCell.h"
#import "SZFirstNormalCell.h"
#import "SZNormalCell.h"
#import <MJRefresh/MJRefresh.h>
#import "SZNetWorkingTool.h"
#import "SZADModel.h"
#import "SZDataBase.h"


#define KCellID @"CellID"






@interface SZColumnTableView ()<UITableViewDataSource , UITableViewDelegate>

@end

//标记是下拉刷新和上拉加载
BOOL isDownOrUpRefresh = YES;





@implementation SZColumnTableView


- (void)awakeFromNib
{

    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellID];
    self.separatorColor = [UIColor clearColor];
    
    self.delegate = self;
    self.dataSource = self;
    
    //配置刷新视图
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefreshAction)];
    
    self.offset = 0;
    
}



- (void)downRefreshAction
{

//    NSLog(@"下拉刷新!!");
    
    isDownOrUpRefresh = YES;

//    NSLog(@"----currentIndex = %ld" , self.currentColumnIndex);
    
    if (self.currentColumnIndex == 0)
    {
        
        [self loadFirstColumnData];
        
    }
    else
    {
        
        //出第一个栏目之外的栏目，进行下拉刷新
        
        [self loadNormalColumnData];
        
    }
    
    
    
}
#pragma mark - 请求第一个栏目的数据

- (void)loadFirstColumnData
{
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    NSString *urlStr = @"banners";
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        SZCycleModel *model = [SZCycleModel modelWithDictionary:dict[@"data"]];
        
        //判断是下拉还是上拉行为
        if (isDownOrUpRefresh)
        {
            
            //是下拉
            self.cycleModelArr = model.banners;
            
            //下拉刷新中的轮播数据模型请求完毕，更新数据库中的模型数据
            [SZDataBase refreshCycleModelData:[model.banners mutableCopy]];
            

        }
        else
        {
        
            //是上拉,不用更新轮播数据
        }

        
        //开始请求轮播下方的广告数据
        [self loadADData];
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"表视图第一个栏目数据请求失败!!");
        
    }];
    
    
    
    
}

- (void) loadADData
{
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    NSString *urlStr = @"secondary_banners?gender=1&generation=1";
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        SZADModel *model = [SZADModel modelWithDictionary:dict[@"data"]];

        if (isDownOrUpRefresh)
        {
            
            self.secondBannerModelArr = model.secondary_banners;

            //刷新数据库中的数据模型
            [SZDataBase refreshSecondModelData:[model.secondary_banners mutableCopy]];
            
            
        }
        else
        {
        
            //是上拉，不用更新广告数据
            
        }

        
        //开始请求
        [self loadNormalData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"表视图广告数据请求失败!!");
        
    }];
    
    
}

//开始请求普通的数据模型
- (void) loadNormalData
{
    

    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    NSString *urlStr = @"";
    
    
    if (isDownOrUpRefresh)
    {
        
        self.offset = 0;
        
        urlStr = @"channels/100/items_v2?ad=2&gender=1&generation=1&limit=20&offset=0";

    }
    else
    {
    
        self.offset += 20;

        urlStr = [NSString stringWithFormat:@"channels/100/items_v2?ad=2&gender=1&generation=1&limit=20&offset=%ld" , self.offset];
    }
    

    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        
        SZNormalCellModel *model = [SZNormalCellModel modelWithDictionary:dict[@"data"]];
        
        if (isDownOrUpRefresh)
        {
            //是下拉刷新
            self.giftModelArr = [model.items mutableCopy];
            
            /**
             *  是下拉刷新，获取到了普通的模型数据，那么我们应该先删除数据库中所以已经加载过的当前栏目的普通数据模型，不管有多少个，都进行删除，然后在将这20个数据模型加入数据库中。
             */
            [SZDataBase refreshNormalModelData:[model.items mutableCopy] withIndex:self.currentColumnIndex];
            
            
        }
        else
        {
        
            //是上拉刷新
            NSArray *arr = [NSArray arrayWithArray:model.items];
            
            [self.giftModelArr addObjectsFromArray:arr];
            
            /**
             *  上拉刷新，加载了更多的数据，这时候应该添加更多的数据到数据库中，直到你刷新了，才会用刷新获取到的20个模型数据，去替换这些更多的数据
             */
            
            for (SZItemModel *itemModel in model.items)
            {
                
                itemModel.columnNumber = self.currentColumnIndex;
                
                [SZDataBase addNormalModel:itemModel];

            }
            
            
        }
        
        //获取数据全部完成，结束刷新状态
        [self.mj_header endRefreshing];
        
        //全部数据更新完成，开始刷新表视图
        [self reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"表视图刷新内容请求失败!!");
        
    }];
    
    
}


//------------------------------------------------
#pragma mark - 加载除了第一个栏目之外的栏目数据
- (void)loadNormalColumnData
{
    
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    //根据栏目的id，拼接成对应的URL
    
    //女票URL：http://api.liwushuo.com/v2/channels/10/items_v2?gender=1&limit=20&offset=0&generation=1
    //[self.channelModel.column_id integerValue]
    NSString *urlStr = @"";
    
    if (isDownOrUpRefresh)
    {
        
        self.offset = 0;
        
        urlStr = [NSString stringWithFormat:@"channels/%ld/items_v2?gender=1&limit=20&offset=0&generation=1" , [self.channelModel.column_id integerValue]];
//        urlStr = @"channels/100/items_v2?ad=2&gender=1&generation=1&limit=20&offset=0";
        
    }
    else
    {
        
        self.offset += 20;
        
        urlStr = [NSString stringWithFormat:@"channels/%ld/items_v2?gender=1&limit=20&offset=%ld&generation=1" , [self.channelModel.column_id integerValue],self.offset];
//        NSLog(@"urlStr = %@" , urlStr);
        
    }
    
    
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        SZNormalCellModel *model = [SZNormalCellModel modelWithDictionary:dict[@"data"]];
        
        
        if (isDownOrUpRefresh)
        {
            
            self.normalModelArr = [model.items mutableCopy];
            
            //更新数据库中的数据
            [SZDataBase refreshNormalModelData:[model.items mutableCopy] withIndex:self.currentColumnIndex];

        }
        else
        {
        
            NSArray *arr = model.items;
            [self.normalModelArr addObjectsFromArray:arr];
            
            /**
             *  加载了其他栏目的更多数据，要实时的添加到数据库中，知道刷新了这个栏目，才会用刷新得到的20个数据替换加载更多获取到的所有数据
             */
            for (SZItemModel *itemModel in model.items)
            {
                
                itemModel.columnNumber = self.currentColumnIndex;
                [SZDataBase addNormalModel:itemModel];
                
            }
            
            
            //添加应该不会走setter方法，所以这里再调用一次
            [self reloadData];
            
            
            
            
        }

        
        //请求数据完毕，关闭刷新
        [self.mj_header endRefreshing];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"表视图其他栏目请求失败!!");
        
    }];
    
    
}


#pragma mark - 属性的setter方法

- (void)setGiftModelArr:(NSMutableArray *)giftModelArr
{

    if (_giftModelArr != giftModelArr)
    {
        _giftModelArr = giftModelArr;
    }
    
    
    [self reloadData];
}

- (void)setNormalModelArr:(NSMutableArray *)normalModelArr
{

    if (_normalModelArr != normalModelArr)
    {
        _normalModelArr = normalModelArr;
    }
    
    [self reloadData];
    
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
}



#pragma mark - 集合视图dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger count = 0;
    
    switch (self.currentColumnIndex)
    {
        case 0:
        {
            
            if (self.giftModelArr.count > 0)
            {
                count = self.giftModelArr.count + 1;

            }
            else
            {
            
                count = 0;
            }
            

        }


        break;
            
        default:
            
            count = self.normalModelArr.count;
            
        break;
    }
    
    return count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = nil;
    NSString *resueID = @"";
    NSInteger cellIndex = 0;
//    NSLog(@"cell----%ld" , self.currentColumnIndex);
    /**
     *  根据不同的栏目索引，获取到复用ID和从xib加载视图的索引
     */
    switch (self.currentColumnIndex)
    {
        case 0:
        {
        
            if (indexPath.row == 0)
            {
                
                resueID = @"firstCell";
                cellIndex = 0;
                
            }
            else if(indexPath.row == 1)
            {
            
                resueID = @"firstNormalCell";
                cellIndex = 1;
            }
            else
            {
            
                resueID = @"normalCell";
                cellIndex = 2;
            }
            
            
        }

        break;
            
            
        default:
            resueID = @"normalCell";
            cellIndex = 2;

            break;
    }
    

    //通过对应的复用ID获取cell
    cell = [tableView dequeueReusableCellWithIdentifier:resueID];
    if (cell == nil)
    {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SZTableViewCell" owner:self options:nil] objectAtIndex:cellIndex];

    }
    
    
    //开始根据不同的复用ID，给cell传入不同的数据
    if ([resueID isEqualToString:@"firstCell"])
    {
        
        NSMutableArray *cycleImageMuArr = [NSMutableArray array];
        for (SZBannerModel *model in self.cycleModelArr)
        {
            [cycleImageMuArr addObject:model.image_url];
        }
        
        SZFirstCell *firstCell = (SZFirstCell *)cell;
        
        firstCell.bannerMuArr = [self.cycleModelArr mutableCopy];

        firstCell.cycleImageURLArr = cycleImageMuArr;
        firstCell.secondModelArr = self.secondBannerModelArr;
        
    }
    else if([resueID isEqualToString:@"firstNormalCell"])
    {
    
        
        //传入礼物cell的模型
        SZFirstNormalCell *firstNormalCell = (SZFirstNormalCell *)cell;
        firstNormalCell.itemModel = self.giftModelArr[indexPath.row - 1];

        
        
        
    }
    else if ([resueID isEqualToString:@"normalCell"])
    {
    
        SZNormalCell *normalCell = (SZNormalCell *)cell;
        if (self.currentColumnIndex == 0)
        {
            
            normalCell.itemModel = self.giftModelArr[indexPath.row - 1];
            
            //判断用户是否已经滑动到了最后一个cell，如果是最后一个cell，那么自动的调用网络请求，去加载更多的数据，并且用蒙版提醒用户。如果没有网络，那么就刷不出新的数据。
            
            if (indexPath.row == self.giftModelArr.count)
            {
                
                //表示上拉加载更多
                isDownOrUpRefresh = NO;
                
                [self loadNormalData];
                
            }
            
            
        }
        else
        {
        
            normalCell.itemModel = self.normalModelArr[indexPath.row];
            
            if (indexPath.row == self.normalModelArr.count-1)
            {
                
                //表示上拉加载更多
                isDownOrUpRefresh = NO;
                
                [self loadNormalColumnData];
                
            }
            
        }
        
        
        
    }
    

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat height = 0;
    
    if (self.currentColumnIndex == 0)
    {
        
        switch (indexPath.row)
        {
            case 0:
                height = 250;
                break;
            case 1:
                height = 300;
                break;
            default:
                height = 250;
                break;
        }
        
    }
    else
    {
    
        height = 250;
    }
    
    
    return height;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

    SZItemModel *itemModel = nil;
    NSLog(@"将要选中了%ld" , indexPath.row);
//    NSLog(@"%@" , self.giftModelArr);
    if (self.currentColumnIndex == 0)
    {
        itemModel = self.giftModelArr[indexPath.row  - 1];
        
        NSLog(@"id = %@" , itemModel.post_id);
        
    }
    else
    {
    
        itemModel = self.normalModelArr[indexPath.row];
//        NSLog(@"id = %@" , itemModel.post_id);
        
    }
    //本来打算使用代理，可是发现类和类之间的跨度太大，无法在首页的SZHo    zmeViewController中拿到当前这个tableView，这样就无法设置代理对象了，所以考虑使用通知来做，如果当初我将SZColumnContentColleVC的视图添加到SZHomeViewController的view上的时候，让SZColumnContentColleVC成为导航控制器的自控制器应该会好一些。
    //开始发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KPushCellDetailPage
        object:self
        userInfo:@{
                   
                   @"post_id" : itemModel.post_id
                   
                   }];
    
    
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //点击了某一个cell，开始加载push一个控制器，控制器视图上带有网页视图。
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
