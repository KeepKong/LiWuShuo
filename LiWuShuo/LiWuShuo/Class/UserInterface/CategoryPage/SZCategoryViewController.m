//
//  SZCategoryViewController.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCategoryViewController.h"
#import "SZTitleView.h"
#import "SZCategoryBgCollVC.h"




@interface SZCategoryViewController ()


@property (nonatomic , strong) UISearchBar *searchBar;



@property (nonatomic , assign) NSInteger currentIndex;

//搜索栏下方的内容集合视图
@property (nonatomic , strong) SZCategoryBgCollVC *bgColleVC;

@end

@implementation SZCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //配置导航栏
    [self _configureCategoryNavigationBar];
    
    //配置导航栏下方的搜索栏
    [self _configureSearchBar];
    
    
    //配置所搜栏下方的集合视图
    [self _configureContentCollView];
    
}


//配置所搜栏下方的集合视图
- (void)_configureContentCollView
{

    
    //内容集合视图的背景视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 50 , KScreenWidth, KScreenHeight - 64 - 50 - 49)];
    bgView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:bgView];
    
    
    self.bgColleVC = [[SZCategoryBgCollVC alloc] init];
    
//    [self.navigationController addChildViewController:self.bgColleVC];
    
    
    [bgView addSubview:self.bgColleVC.collectionView];
    
    
}

//配置搜索栏
- (void) _configureSearchBar
{

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,  64 + 10, KScreenWidth - 20, 30)];
    
    self.searchBar.placeholder = @"选份走心好礼送给Ta";

    
    self.searchBar.barTintColor = [UIColor whiteColor];
    

    //设置样式，去除搜索框上下两边的一像素线。
    self.searchBar.searchBarStyle =  UISearchBarStyleMinimal;
    
    
    //通过KVC获取到searchBar上的输入文本框
    UITextField *textField = [self.searchBar valueForKey:@"_searchField"];
    
    textField.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    textField.borderStyle = UITextBorderStyleNone;
    

    [self.view addSubview:self.searchBar];
    
    
    
    
}


- (void)_configureCategoryNavigationBar
{
    
    SZTitleView *titleView = [SZTitleView getIndicatorView];
    titleView.frame = CGRectMake(0, 0, 150, 44);
    
    self.navigationItem.titleView = titleView;
    
    titleView.gongLueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    
    
    
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
