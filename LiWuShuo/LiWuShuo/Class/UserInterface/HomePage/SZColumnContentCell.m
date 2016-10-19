//
//  SZColumnContentCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZColumnContentCell.h"
#import "SZNetWorkingTool.h"

#import "SZCycleModel.h"
#import "SZADModel.h"
#import "SZNormalCellModel.h"

#import "SZDataBase.h"


#import "NSDictionary+GeneratePropertyCodes.h"

@interface SZColumnContentCell ()

//保存第一个栏目的轮播模型数组
@property (nonatomic , copy) NSArray *cycleModelArr;

/**
 *  保存轮播下方的展示视图模型数组
 */
@property (nonatomic , copy) NSArray *secondBannerModelArr;
/**
 *  保存第一个栏目中普通数据模型数组
 */
@property (nonatomic , copy) NSArray *firstColumnNormalModelArr;



@end


@implementation SZColumnContentCell

- (void)awakeFromNib
{

//    NSLog(@"cell");
    
    
}

- (void)setCurrentColumnIndex:(NSInteger)currentColumnIndex
{

    if (_currentColumnIndex != currentColumnIndex)
    {
        _currentColumnIndex = currentColumnIndex;
    }
    
//    NSLog(@"currentIndex = %ld" , currentColumnIndex);
    self.channelModel = self.columnArr[_currentColumnIndex];
    
    //将当前的栏目数据传给cell上的表视图，在表视图在上下拉的时候起作用。
    self.contentTableV.channelModel = self.channelModel;
    
    //将当前网络请求中数据的分页偏移量重置
    self.contentTableV.offset = 0;
    

    
}

#pragma mark - lazy
- (UIImageView *)animationImageV
{

    if (_animationImageV == nil)
    {
        
//        NSLog(@"--------------走了lazy方法");
        
        _animationImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        
        _animationImageV.center = CGPointMake(self.animationView.bounds.size.width/2.0,self.animationView.bounds.size.height/2.0 - 50);
        
        _animationImageV.backgroundColor = [UIColor whiteColor];
        
        
        //开始添加gif动画图片
        NSMutableArray *imagesMuArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i <= 22; i++)
        {
            UIImage *animationImage = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%02ld" , i]];
            
            [imagesMuArr addObject:animationImage];
        }
        
        _animationImageV.animationImages = imagesMuArr;
        
        _animationImageV.animationDuration = 1;
        _animationImageV.animationRepeatCount = HUGE;
        //    [self.animationImageV startAnimating];
        _animationImageV.hidden = YES;
    }
    
    
    return _animationImageV;
    
}


#pragma mark - 加载网络数据时候的蒙版视图
- (void)addLoadAnimationView
{


    /**
        如果数据库中已经存在了这个数据，那么我们就不应该再加上蒙版视图了，
        这里还是得根据当前的索引值去判断。
     */
    if (self.currentColumnIndex == 0)
    {
        
        NSMutableArray *cycleMuArr = [SZDataBase gainCycleModel];
        NSMutableArray *secondMuArr = [SZDataBase gainSecondModels];
        NSMutableArray *firstColumnNormalMuArr = [SZDataBase gainNormalModelsWithColumnIndex:self.currentColumnIndex];
        
        if (cycleMuArr.count != 0 && secondMuArr.count != 0 && firstColumnNormalMuArr.count != 0)
        {
//            NSLog(@"第一个");
            [self loadFirstColumnData];
            
            return;
        }
        
        
    }
    else
    {
    
        NSMutableArray *otherNormalMuArr = [SZDataBase gainNormalModelsWithColumnIndex:self.currentColumnIndex];
        
        if (otherNormalMuArr.count != 0)
        {
            [self loadNormalColumnData];
            return;
        }
        
    }
    

    
    
    
    
    
    if ([self.contentView viewWithTag:888888] == nil)
    {
        //-------------------添加蒙版视图------------------
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49 - 35 - 64)];
        self.animationView.tag = 888888;
        self.animationView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.animationView];
        
        //--------------------添加动画视图----------------
        
        [self.animationView addSubview:self.animationImageV];
    }
    

    
    
    if (self.currentColumnIndex == 0)
    {
       
        [self loadFirstColumnData];
        
    }


    

    
}
- (void)removeAnimationView
{

    
    [UIView animateWithDuration:1 animations:^{
        
        
        self.animationImageV.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        
        
        self.animationImageV.hidden = YES;
        [self.animationImageV stopAnimating];

        
        [self.animationView removeFromSuperview];
        //为了防止cell复用的时候，不走lazy中的方法，因为lazy方法中有判断是否为nil，如果为nil，那么就不走里面的创建方法了，而复用过来的cell如果在移除的时候没有置为nil，单单靠移除，有可能不为nil。
        self.animationImageV = nil;
        self.animationView = nil;

    }];
    
    
    
}




#pragma mark - 请求第一个栏目的数据


- (void)loadFirstColumnData
{
    

    
    
    /**
     *  在程序运行之后，判断当前网络请求过来的数据
     */
    
    NSMutableArray *cycleMuArr = [SZDataBase gainCycleModel];
    if (cycleMuArr.count == 0)
    {
        
        //表示开始进行网络请求数据了，马上加上加载的动画
        self.animationImageV.hidden = NO;
        [self.animationImageV startAnimating];
        
//        NSLog(@"数据库中没有轮播数据模型,开始网络加载！");
        AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
        NSString *urlStr = @"banners";
        
        
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            SZCycleModel *model = [SZCycleModel modelWithDictionary:dict[@"data"]];
            
            
            self.cycleModelArr = model.banners;
            
            //请求轮播数据完成，
            self.contentTableV.cycleModelArr = self.cycleModelArr;
            
            //开始请求轮播下方的广告数据
            [self loadADData];
            
            
            /**
             *
             *  将请求到的数据模型保存到数据库中
             */
            
            for (SZBannerModel *bannerModel in model.banners)
            {
                
                bannerModel.columnNumber = self.currentColumnIndex;
//                NSLog(@"当前栏目%ld" , self.currentColumnIndex);
                [SZDataBase addFirstColumnCycleModel:bannerModel];
                
            }
            
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"轮播请求失败!!");
            
        }];
        
    }
    else
    {
    
//        NSLog(@"数据库中已经有轮播数据了！！");
        
        self.cycleModelArr = cycleMuArr;
        
        //请求轮播数据完成，
        self.contentTableV.cycleModelArr = cycleMuArr;
        
        //开始请求轮播下方的广告数据
        [self loadADData];
    }
    
    
    

    
    
    
    
}

- (void) loadADData
{

    
    NSMutableArray *secondMuArr = [SZDataBase gainSecondModels];
    
    
    if (secondMuArr.count == 0)
    {
        
//        NSLog(@"数据库中没有轮播下方数据模型，请求网络加载");
        AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
        NSString *urlStr = @"secondary_banners?gender=1&generation=1";
        
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            SZADModel *model = [SZADModel modelWithDictionary:dict[@"data"]];
            
            self.secondBannerModelArr = model.secondary_banners;
            
            self.contentTableV.secondBannerModelArr = self.secondBannerModelArr;
            
            //开始请求
            [self loadNormalData];
            
            /**
             *  保存轮播下方模型数据
             *
             */
            for (SZSecondBanner *banner in model.secondary_banners)
            {
    
                banner.columnNumber = self.currentColumnIndex;
    
                [SZDataBase addSecondModel:banner];
    
    
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"广告请求失败!!");
            
        }];
    }
    else
    {
    
//        NSLog(@"数据库中已有广告数据模型");
        self.secondBannerModelArr = secondMuArr;
        
        self.contentTableV.secondBannerModelArr = secondMuArr;
        //开始请求
        [self loadNormalData];
        
    }
    

    
    
}

//开始请求普通的数据模型
- (void) loadNormalData
{

    
    /**
     *  取出数据库中的第一个栏目的普通模型
     */
    NSMutableArray *normalsMuArr = [SZDataBase gainNormalModelsWithColumnIndex:self.currentColumnIndex];

    if (normalsMuArr.count == 0)
    {
        
//        NSLog(@"数据库中没有栏目一的普通数据，进行网络加载!!");

        
        AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
        NSString *urlStr = @"channels/100/items_v2?ad=2&gender=1&generation=1&limit=20&offset=0";
        
        
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //        [dict[@"data"][@"items"][0] generatePropertyCodes];
            SZNormalCellModel *model = [SZNormalCellModel modelWithDictionary:dict[@"data"]];
            
            self.firstColumnNormalModelArr = model.items;
            
            
            self.contentTableV.giftModelArr = [self.firstColumnNormalModelArr mutableCopy];
            
            //第一个栏目cell上的数据请求全部完成，关闭请求动画
            [self performSelector:@selector(removeAnimationView) withObject:nil afterDelay:0.3];
            
            
            /**
             *  请求完毕，向数据库写入模型数据
             */
            for (SZItemModel *item in model.items)
            {
    
                item.columnNumber = self.currentColumnIndex;
//                NSLog(@"当前栏目是%ld" , item.columnNumber);
    
                [SZDataBase addNormalModel:item];
    
                
            }
 
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"礼物请求失败!!");
            
        }];
    }
    else
    {
    
//        NSLog(@"数据库中已经存在栏目一的普通数据");
        self.firstColumnNormalModelArr = normalsMuArr;
        
        
        self.contentTableV.giftModelArr = normalsMuArr;
        

        
    }
    

}

//------------------------------------------------
#pragma mark - 加载除了第一个栏目之外的栏目数据
- (void)loadNormalColumnData
{

    
    

    
    NSMutableArray *otherNormalsMuArr = [SZDataBase gainNormalModelsWithColumnIndex:self.currentColumnIndex];

//    for (SZItemModel *m in otherNormalsMuArr)
//    {
//        NSLog(@"iamge_url = %@" , m.cover_image_url);
//    }
    if (otherNormalsMuArr.count == 0)
    {
        
        /**
         *  开始动画
         */
        self.animationImageV.hidden = NO;
        [self.animationImageV startAnimating];
        
//        NSLog(@"第%ld个栏目的数据在数据库中没有，进行网络请求!!" , self.currentColumnIndex);
        AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
        
        //根据栏目的id，拼接成对应的URL
        
        //女票URL：http://api.liwushuo.com/v2/channels/10/items_v2?gender=1&limit=20&offset=0&generation=1
        
        NSString *urlStr = [NSString stringWithFormat:@"channels/%ld/items_v2?gender=1&limit=20&offset=0&generation=1" , [self.channelModel.column_id integerValue]];

        
        
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            SZNormalCellModel *model = [SZNormalCellModel modelWithDictionary:dict[@"data"]];
            
            //保存其他栏目中的礼物模型数据
            
            self.normalModelArr = model.items;
            
            //将数据传给表视图，使其刷新数据
            self.contentTableV.normalModelArr = [self.normalModelArr mutableCopy];

            
            //第一个栏目cell上的数据请求全部完成，关闭请求动画
            [self performSelector:@selector(removeAnimationView) withObject:nil afterDelay:0.2];
            
            /**
             *  数据请求完成，将模型保存到数据库中
             */
            for (SZItemModel *otherItem in model.items)
            {
    
//                NSLog(@"currentIndex =  %ld" , self.currentColumnIndex);
                otherItem.columnNumber = self.currentColumnIndex;
                [SZDataBase addNormalModel:otherItem];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"其他栏目数据请求失败!!");
            
        }];
        
    }
    else
    {
    
//        NSLog(@"第%ld个栏目的数据已经在数据库中存在" , self.currentColumnIndex);
        
        self.normalModelArr = otherNormalsMuArr;
        
        //将数据传给表视图，使其刷新数据
        self.contentTableV.normalModelArr = otherNormalsMuArr;

    }
    

}



@end
