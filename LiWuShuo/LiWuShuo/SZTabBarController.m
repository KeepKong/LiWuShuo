//
//  SZTabBarController.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTabBarController.h"

@interface SZTabBarController ()

@end

@implementation SZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

        
    
    
    
}



- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    

    
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tab_first"] selectedImage:[UIImage imageNamed:@"tab_first_sel"]];
    
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"榜单" image:[UIImage imageNamed:@"tab_third"] selectedImage:[UIImage imageNamed:@"tab_third_sel"]];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"tab_second"] selectedImage:[UIImage imageNamed:@"tab_second_sel"]];
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_fifth"] selectedImage:[UIImage imageNamed:@"tab_fifth_sel"]];
    
    
    NSArray *itemsArr = [NSArray arrayWithObjects:item1 , item2 , item3 , item4, nil];
    
    
    NSInteger i = 0;
    
    for (UINavigationController *navi in self.viewControllers)
    {
        
        
        
        navi.tabBarItem = itemsArr[i];
        
        i++;
        
    }
    
    
    //设置tabBar上文字选中时候的渲染颜色
    self.tabBar.tintColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
    
    
    //设置tabBar的颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    
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
