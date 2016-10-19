//
//  SZTopViewController.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopViewController.h"
#import "SZTopCollVC.h"
#import "SZTopBGCollVC.h"
#import "SZNetWorkingTool.h"
#import "NSDictionary+GeneratePropertyCodes.h"
#import "SZTopColumnModel.h"
#import "SZTopIndicatorView.h"

#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"

#import <UMSocialCore/UMSocialDataManager.h>


@interface SZTopViewController ()


@property (nonatomic , strong) UIView *columnBgView;
@property (nonatomic , strong) UIView *indicatorView;

/**
 *  栏目集合视图
 */
@property (nonatomic , strong) SZTopCollVC *topCollVC;

/**
 *  栏目内容BG集合视图控制器
 */
@property (nonatomic , strong) SZTopBGCollVC *bgCollVC;

@end

@implementation SZTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //配置导航栏
    [self _configureNavigationBar];
    
    //配置栏目视图
    [self _configureColumnView];
    
    //配置榜单内容BG集合视图
    [self _configureTopBGColleVC];
    
    //加载榜单栏目数据
    [self _loadTopColumnData];
    
    

    
    
    
}


-(void)getAuthInfoFromSina
{

    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        
//        [self.tableView reloadData];
        UMSocialAuthResponse *authresponse = result;
        NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}


- (void)getUserInfoFromSina
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)shareTextToSina
{
    
    
    NSString *text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - 加载榜单栏目数据

- (void)_loadTopColumnData
{
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    
    NSString *urlStr = @"ranks_v2/ranks";
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        SZTopColumnModel *model = [SZTopColumnModel modelWithDictionary:dict[@"data"]];
        
        self.topCollVC.topColumnArr = model.ranks;
        self.bgCollVC.topColumnArr = model.ranks;
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"请求失败!!");
        
        
    }];
    
    
}

//配置榜单内容BG集合视图
- (void) _configureTopBGColleVC
{

    
    //配置内容集合视图的背景视图
    UIView *contentColleV = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 35, KScreenWidth, KScreenHeight - 64 - 35 - 49)];
    contentColleV.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:contentColleV];
    
    
    self.bgCollVC = [[SZTopBGCollVC alloc] init];
    
    [contentColleV addSubview:self.bgCollVC.collectionView];
    
    
}



//配置栏目视图
- (void)_configureColumnView
{


    //配置栏目集合视图的背景视图
    self.columnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 35)];
    self.columnBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.columnBgView];
    
    //设置红色块，作为栏目指示块
    self.indicatorView = [SZTopIndicatorView defaultTopIndicatiorView];
    self.indicatorView.frame = CGRectMake(10, self.columnBgView.bounds.size.height - 5, 80, 3);
    

    self.indicatorView.backgroundColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
    
    [self.columnBgView addSubview:self.indicatorView];
    
    
    //添加栏目集合视图
    self.topCollVC = [[SZTopCollVC alloc] init];
    [self.columnBgView addSubview:self.topCollVC.collectionView];
    
}



//配置导航栏
- (void)_configureNavigationBar
{



    self.navigationItem.title = @"礼物榜";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       
       NSFontAttributeName : [UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName : [UIColor whiteColor]
       
       }];
    
    //配置右边的导航按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    rightBtn.tintColor = [UIColor whiteColor];

    //友盟集成测试--KeepKong
    [rightBtn setImage:[UIImage imageNamed:@"common_share_light"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    
    

}

#pragma mark - 分享事件响应
- (void)shareAction: (UIButton *)sender
{

    NSLog(@"点击了分享按钮!!");
    

    /**
     *  这个面板是sheet类型，不怎么好看
     */
    
    

    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
       
//        NSLog(@"platformType = %ld" , platformType);
//        NSLog(@"分享数据");
        
        switch (platformType)
        {
            case UMSocialPlatformType_Sina:
                [self shareTextToSina];
                break;
                
            default:
                break;
        }
        
        
        
    }];
    
    
    
    
    
//    
//    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
//    
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
//    [UMSocialData defaultData].extConfig.title = @"分享的title";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57cfd14767e58e4421000d0a"
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                       delegate:self];
    
    
    
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

@end
