//
//  SZHomeNaviController.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZHomeNaviController.h"

@interface SZHomeNaviController ()

@end

@implementation SZHomeNaviController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    
    viewController.hidesBottomBarWhenPushed = NO;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
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
