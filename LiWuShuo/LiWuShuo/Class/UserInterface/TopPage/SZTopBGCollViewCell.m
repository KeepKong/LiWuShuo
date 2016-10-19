//
//  SZTopBGCollViewCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopBGCollViewCell.h"
#import "SZNetWorkingTool.h"
#import "NSDictionary+GeneratePropertyCodes.h"
#import "SZTopContentModel.h"
#import "SZDataBase.h"

@implementation SZTopBGCollViewCell


- (void)awakeFromNib
{

    self.isRequest = NO;

}



#pragma mark - lazy
- (UIImageView *)animationImageV
{
    
    if (_animationImageV == nil)
    {
        
        
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
        判断数据库中是否有已经保存过的数据，没有在加载动画，有的话就不加载动画。
     */
    
    
    SZTopContentModel *topContentModel = [SZDataBase gainTopHeaderModelWithIndex:self.currentIndex];

    if (topContentModel != nil)
    {
        
        self.isRequest = YES;
        [self loadTopColumnData];
        
        return;
        
    }
    
    
    UIView *tempView = [self.contentView viewWithTag:999999];
    if (tempView == nil)
    {
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49 - 35 - 64)];
        self.animationView.tag = 999999;
        self.animationView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:self.animationView];
        
        //--------------------添加动画视图----------------
        
        [self.animationView addSubview:self.animationImageV];
    }


    
    if (self.currentIndex == 0)
    {
        self.isRequest = YES;
        [self loadTopColumnData];

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


//加载网络数据
- (void)loadTopColumnData
{

    /**
     *  取出数据库中缓存的模型数据
     */

    
    SZTopContentModel *topHeaderModel = [SZDataBase gainTopHeaderModelWithIndex:self.currentIndex];

    
    
    if (topHeaderModel == nil)
    {
        //开始蒙版视图上的动画
        self.animationImageV.hidden = NO;
        [self.animationImageV startAnimating];
        
        
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
            
            
            
            self.contentCollV.contentModel = model;
            
            /**
             *  将顶部视图等其他数据进行保存
             */
            model.columnNumber = self.currentIndex;
            [SZDataBase addTopOtherModel:model];
            
            /**
             *  当前cell的请求完毕，设置为NO
             */
            self.isRequest = NO;
            

            //数据加载完成，移除蒙版视图
            [self performSelector:@selector(removeAnimationView) withObject:nil afterDelay:0.2];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败!!");
            
        }];
    }
    else
    {
        
        self.isRequest = NO;


        self.contentCollV.contentModel = topHeaderModel;
        
    }
    
    
    

}



@end
