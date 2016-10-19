//
//  SZCellDetailVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/13.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCellDetailVC.h"
#import "SZNetWorkingTool.h"
#import "SZCellDetailModel.h"
#import <UIImageView+WebCache.h>



#import "NSDictionary+GeneratePropertyCodes.h"


@interface SZCellDetailVC ()<UIWebViewDelegate , UIScrollViewDelegate>


@property (nonatomic , strong) UIView *statusBgView;


@end

@implementation SZCellDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tabBarController.tabBar.hidden = YES;

//    self.view.frame = CGRectMake(0, 20, KScreenWidth, KScreenHeight - 49);
//    NSLog(@"frame = %@" , NSStringFromCGRect(self.view.frame));
    self.detailWebView.scrollView.bounces = NO;
    self.detailWebView.delegate = self;
    self.detailWebView.scrollView.delegate = self;
    
    //配置导航栏
    [self _configureNavigationBar];

    //请求详情数据
    [self _loadDetailData];
    

    
    
    
}


#pragma mark - 请求详情数据
- (void)_loadDetailData
{

    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    
    NSString *urlStr = [NSString stringWithFormat:@"posts_v2/%ld" , [self.post_id integerValue]];
    
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
//        [dict[@"data"] generatePropertyCodes];
//        NSLog(@"%@" , dict[@"data"][@"cover_image_url"]);
        
        SZCellDetailModel *model = [SZCellDetailModel modelWithDictionary:dict[@"data"]];
        
//        NSLog(@"url = %@" , model.cover_image_url);
        
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.url]];
        
        
        //设置喜欢数等数量
        [self _configureButtomBtn:model];
        
        
        [self.detailWebView loadRequest:request];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

#pragma mark - 设置底部喜欢的按钮的数量
- (void)_configureButtomBtn:(SZCellDetailModel *)model
{

    self.loveLable.text = [NSString stringWithFormat:@"%ld" , [model.likes_count integerValue]];
    
    self.shareLabel.text = [NSString stringWithFormat:@"%ld" , [model.shares_count integerValue]];
    self.commentLabel.text = [NSString stringWithFormat:@"%ld" , [model.comments_count integerValue]];
    
    
}



#pragma mark - 配置导航栏

- (void)_configureNavigationBar
{

    /**
        设置状态栏背景视图，将其添加到导航栏的上面
     
     */
    self.statusBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, KScreenWidth, 20)];
    self.statusBgView.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar addSubview:self.statusBgView];
    
    
    
    
    /**
        导航栏标题
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleLabel.text = @"攻略详情";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    //先将titleLabel的透明度设置成0，再通过移动webView来设置导航栏和titleLabel整体的透明度。
    //这里设置这个没有效果，不知道为什么。
//    titleLabel.alpha =0.0;

    self.navigationItem.titleView = titleLabel;

    
//    self.navigationItem.title = @"攻略详情";
    self.navigationController.navigationBar.titleTextAttributes =
    @{
      
      NSForegroundColorAttributeName : [UIColor whiteColor]
      
      };

    //左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    
    leftBtn.tintColor = [UIColor whiteColor];
    
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    
    //右边按钮
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [right setTitle:@"查看全集" forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(queryAllAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    //设置导航栏透明效果
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:0.0]];
    
//    self.navigationController.navigationBar.alpha = 0.5;
    
    //去掉导航栏下面的一像素线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

//    NSLog(@"在滑动了!!");
    UILabel *label = (UILabel *)self.navigationItem.titleView;

    
    CGFloat offset = scrollView.contentOffset.y;
//    NSLog(@"y = %lf" , offset);
    CGFloat alp = 0.0;
    if (offset >= -64 && offset <= 0)
    {
        CGFloat temp = fabs(offset);
        
        alp = 1 - temp/64.0;
//        NSLog(@"%lf" , alp);
        label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:alp];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:alp]];

        
    }
    
    

}


- (void)queryAllAction:(UIButton *)sender
{

    NSLog(@"点击了查看全部按钮!");

}


- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{

    [self.statusBgView removeFromSuperview];
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self preferredStatusBarStyle];
    
}


#pragma mark - webView delegate
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//
//    NSLog(@"已经开始加载%@" , webView.request);
//}
//
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

//    NSLog(@"将要开始加载%@" , request);
    NSString *JSStr = [NSString stringWithFormat:@"document.getElementsByClassName('download_nav_bar')[0].remove();"];
    NSString *bottomStr = @"document.getElementsByClassName('download_block_bar')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:JSStr];
    [webView stringByEvaluatingJavaScriptFromString:bottomStr];
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

//    NSLog(@"request = %@" , webView.request);
    
//    NSString *JSStr = [NSString stringWithFormat:@"document.getElementsByClassName('download_nav_bar')[0].remove();"];
//    NSString *bottomStr = @"document.getElementsByClassName('download_block_bar')[0].remove();";
//    [webView stringByEvaluatingJavaScriptFromString:JSStr];
//    [webView stringByEvaluatingJavaScriptFromString:bottomStr];
    
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
