//
//  SZHomeViewController.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZHomeViewController.h"
#import "SZColumnCollecVC.h"
#import "SZColumnContentColleVC.h"
#import "SZNetWorkingTool.h"
#import "SZColumnModel.h"
#import "SZIndicatorView.h"
#import "SZBGColumnCollVC.h"
#import "SZCellDetailVC.h"
#import "SZCycleDetailTableVC.h"

#import "NSDictionary+GeneratePropertyCodes.h"


@interface SZHomeViewController ()<UISearchBarDelegate>

//栏目集合视图的背景视图
@property (nonatomic , strong) UIView *columnBgView;



//栏目集合视图
@property (nonatomic , strong) SZColumnCollecVC *columnCollecVC;

//栏目中详情内容的集合视图SZColumnContentColleVC
@property (nonatomic , strong) SZColumnContentColleVC *columnContentColleVC;

//在栏目集合视图上方的一个隐藏的切换频道视图
@property (nonatomic , strong) UIView *cutChannelView;

//配置栏目文本详情文本集合视图,层级是在栏目视图的后面
@property (nonatomic , strong) SZBGColumnCollVC *bgColumCollVC;
//隐藏栏目视图的背景视图
@property (nonatomic , strong) UIView *bgColumCollView;

@property (nonatomic , strong) UISearchBar *searchBar;

@property (nonatomic , strong) UITapGestureRecognizer *cancleKeyBoardtap;
@end

@implementation SZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    //配置导航栏
    [self _configureNavi];
    
    //配置对应栏目中详情内容的集合视图
    [self _configureColumnContentColleV];
    
    //配置所有栏目的集合视图
    [self _configureColumnColleV];
    
    //加载网络数据
    [self _loadColumnData];
    
    
    /**
     *  注册成为点击cell上，查看礼物详情页面的观察者
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushCellDetailAction:) name:KPushCellDetailPage object:nil];
    
    /**
     *  注册成为点击轮播图片，查看页面详情的观察者
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushCycleDetailAction:) name:KPushCycleDetailPage object:nil];
    
}

#pragma mark - 点击轮播图片的通知
- (void)pushCycleDetailAction:(NSNotification *)notification
{

    NSLog(@"接收到了通知");
    
    NSNumber *request_id = notification.userInfo[@"request_id"];
    
    //这里使用这个会出现问题
//    SZCycleDetailTableVC *detailPage = [[SZCycleDetailTableVC alloc]initWithNibName:@"SZCycleDetailTableVC" bundle:nil];
    
    SZCycleDetailTableVC *detailPage = [[SZCycleDetailTableVC alloc] init];
    detailPage.request_id = request_id;
    
    
    [self.navigationController pushViewController:detailPage animated:YES];
    
    
    
}

#pragma mark - 点击cell的通知
- (void)pushCellDetailAction:(NSNotification *)notification
{

    NSNumber *post_id = notification.userInfo[@"post_id"];
    
    
    SZCellDetailVC *detailVC = [[SZCellDetailVC alloc] initWithNibName:@"SZCellDetailVC" bundle:nil];
    detailVC.post_id = post_id;
    
    
    
    [self.navigationController pushViewController:detailVC animated:YES];

    
    
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//    NSLog(@"开始触摸！！");
//}



#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    
//    self.tabBarController.tabBar.hidden = NO;
//    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    //设置导航栏，使其正常显示

    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}



#pragma mark - 加载网络数据
- (void) _loadColumnData
{


    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    NSString *urlStr = @"channels/preset?gender=1&generation=1";
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        

        SZColumnModel *model = [SZColumnModel modelWithDictionary:dict[@"data"]];
        
        self.columnCollecVC.columnArr = model.channels;
        self.columnContentColleVC.columnArr = model.channels;
        self.bgColumCollVC.columnArr = [model.channels mutableCopy];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败!!");
        
    }];
    
    
    
}


#pragma  mark - 配置对应栏目中详情内容的集合视图
- (void) _configureColumnContentColleV
{

    
    //配置内容集合视图的背景视图
    UIView *contentColleV = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 35, KScreenWidth, KScreenHeight - 64 - 35 - 49)];
    contentColleV.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:contentColleV];
    
    
    
    self.columnContentColleVC = [[SZColumnContentColleVC alloc] init];
    
    [contentColleV addSubview:self.columnContentColleVC.collectionView];
    
    
}


//配置栏目集合视图
- (void) _configureColumnColleV
{
    
    
    //配置栏目文本详情文本集合视图,层级是在栏目视图的后面
    //
    self.bgColumCollView = [[UIView alloc] initWithFrame:CGRectMake(0, -(160-64), KScreenWidth, 160)];
    self.bgColumCollView.userInteractionEnabled = YES;
    self.bgColumCollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.bgColumCollView];
    
    
    
    self.bgColumCollVC = [[SZBGColumnCollVC defaultBGColumnCollVC] init];
    
    [self.bgColumCollView addSubview:self.bgColumCollVC.collectionView];
    
    
    //配置栏目集合视图的背景视图
    self.columnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 35)];
    self.columnBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.columnBgView];
    

    //设置红色块，作为栏目指示块
    SZIndicatorView *indicatorView = [SZIndicatorView defaultIndicatiorView];
    indicatorView.frame = CGRectMake(10, self.columnBgView.bounds.size.height - 5, KTopItemWidth, 3);
    
    indicatorView.backgroundColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
    [self.columnBgView addSubview:indicatorView];
    

    //配置栏目集合视图
    self.columnCollecVC = [[SZColumnCollecVC defaultColumnCollecVC]init];

    
    [self.columnBgView addSubview:self.columnCollecVC.collectionView];
    
    //在栏目集合视图上方的一个隐藏的切换频道视图
    self.cutChannelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 30, 35)];
    self.cutChannelView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 35)];
    label.textColor = [UIColor grayColor];
    label.text = @"切换频道";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self.cutChannelView addSubview:label];
    
    
    self.cutChannelView.alpha = 0.0;
    
    [self.columnBgView addSubview:self.cutChannelView];
    
    
    //配置显示所有栏目的按钮
    UIButton *allColumnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    allColumnBtn.tag = 8888;
    
    
    allColumnBtn.frame = CGRectMake(KScreenWidth - 30, 6, 20, 20);
    allColumnBtn.tintColor = [UIColor grayColor];
    allColumnBtn.showsTouchWhenHighlighted = YES;
    [allColumnBtn setImage:[UIImage imageNamed:@"orderList_downArrow"] forState:UIControlStateNormal];
    [allColumnBtn setBackgroundColor:[UIColor whiteColor]];
    
    
    [allColumnBtn addTarget:self action:@selector(selectorColumnAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.columnBgView addSubview:allColumnBtn];
    
    

    
}


#pragma mark - 选择栏目按钮相应方法
- (void) selectorColumnAction:(UIButton *)sender
{

//    NSLog(@"点击了选择栏目按钮");
    
    sender.selected = !sender.selected;


    if (sender.selected)
    {

        //添加一层透明的View，阻止用户的交互
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 35, KScreenWidth, KScreenHeight - 64 - 35 - 49)];

        maskView.tag = 3333;
        maskView.backgroundColor = [UIColor clearColor] ;

        //添加轻击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [maskView addGestureRecognizer:tap];

        
        //插入视图
        [self.view insertSubview:maskView belowSubview:self.bgColumCollView];

        
        
        sender.tintColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            
            
            self.cutChannelView.alpha = 1;
            sender.transform = CGAffineTransformMakeRotation(M_PI);
            self.bgColumCollView.transform = CGAffineTransformMakeTranslation(0, self.bgColumCollVC.collectionView.bounds.size.height + 35);
//            NSLog(@"%lf" , self.bgColumCollVC.collectionView.bounds.size.height);
            
            
        }];
        
    }
    else
    {
    
        //移除蒙版视图
        UIView *maskView = [self.view viewWithTag:3333];
        
        
        [maskView removeFromSuperview];
        

        [UIView animateWithDuration:0.3 animations:^{
            
            
            self.cutChannelView.alpha = 0.0;
            sender.transform = CGAffineTransformIdentity;
            
            self.bgColumCollView.transform = CGAffineTransformIdentity;
            
        }];
    }
    
    
}




//配置导航栏
- (void) _configureNavi
{

    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    leftLabel.text = @"礼物说";
    
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textColor = [UIColor whiteColor];
    

    
//    leftLabel.font = [UIFont systemFontOfSize:16 weight:20];
    leftLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftLabel];
    
    
    //配置中间的搜索栏
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 60 , 40)];
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"十一出行必备";
    self.navigationItem.titleView =self.searchBar;
    
    
    
    //配置右边的导航按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    rightBtn.tintColor = [UIColor whiteColor];
    [rightBtn setImage:[UIImage imageNamed:@"3dtouch_calendar"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    
    
}


//手势相应方法
- (void)tapAction
{

//    NSLog(@"轻击了！");
    
    UIButton *allColumnBtn = [self.columnBgView viewWithTag:8888];
    
    //点击了屏幕，收起栏目详情视图
    [self selectorColumnAction:allColumnBtn];
    
    
}


//登录按钮
- (void) logIn:(UIButton *)sender
{

    NSLog(@"点击了登录按钮！");
    
}


#pragma mark - 搜索栏代理
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//
//    NSLog(@"点击了搜索栏！！");
//}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//
//    NSLog(@"点击了搜索栏");
//    
//    //添加一个透明的视图，接收取消键盘事件。
//    UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 35, KScreenWidth, KScreenHeight - 64 - 35)];
////    markView.alpha = 0.2;
//    markView.tag = 11111111;
//    markView.backgroundColor = [UIColor orangeColor];
//    
//    self.cancleKeyBoardtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboardAction)];
//    [self.view addGestureRecognizer:self.cancleKeyBoardtap];
//    
//    [self.view addSubview:markView];
//    
//    return YES;
//
//}

//- (void)cancelKeyboardAction
//{
//    
//    UIView *markView = [self.view viewWithTag:11111111];
//    [markView removeGestureRecognizer:self.cancleKeyBoardtap];
//    [markView removeFromSuperview];
//    
//    [self.searchBar resignFirstResponder];
//    
//    
//    
//    
//    
//}

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

@end
