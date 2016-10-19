//
//  AppDelegate.m
//  LiWuShuo
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "SZDataBase.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [NSThread sleepForTimeInterval:3];
    
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:246/255.0 green:73/255.0 blue:110/255.0 alpha:1];
    
    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57fa4b2a67e58ebcc90044a6"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1163889390"  appSecret:@"40476607b4bae73ccb071db60251b030" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    /**
     *  改变窗口的背景颜色
     */
    self.window.backgroundColor = [UIColor whiteColor];
    
    
//    NSLog(@"%@" , NSHomeDirectory());
//    NSLog(@"--%@" , [[NSBundle mainBundle] resourcePath]);
    
//    SZDataBase *dataBase = [[SZDataBase alloc] init];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    /**
     *  在APP退出之后，将运行过程中的那些缓存下来的在数据库中的数据全部删除
     */
    
    [SZDataBase removeHomePageAllColumnModel];
    [SZDataBase removeTopPageAllData];
    
    
    
    
}

@end
