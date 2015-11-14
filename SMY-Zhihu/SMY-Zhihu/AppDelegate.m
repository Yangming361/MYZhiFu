//
//  AppDelegate.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "UMSocialWechatHandler.h"
//设置分享到QQ/Qzone的应用Id，和分享url 链接
#import "UMSocialQQHandler.h"
#import "UMSocial.h"

#import "AppDelegate.h"
#import "ContentListViewController.h"
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "RESideMenu.h"
#import "RECommonFunctions.h"
#import "UIViewController+RESideMenu.h"

@interface AppDelegate ()<RESideMenuDelegate>

@end

@implementation AppDelegate



/*
1.contentlist界面scrollview覆盖状态栏


*/





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.frame = [UIScreen mainScreen].bounds;
    //self.window = [[UIWindow alloc] initWithFrame:[];
    
    [self setStartUI];
    
    [self thirdLoaginUM];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
   // LoginViewController *login = [[LoginViewController alloc] init];

    return YES;
}

- (void)thirdLoaginUM
{
    //初始化
    [UMSocialData setAppKey:@"5556a53667e58e1bb500661d"];
    //设置微信AppId、appSecret，分享url
    //[UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

}

-(void)setStartUI
{
    ContentListViewController *clvc = [[ContentListViewController alloc ] init];
    clvc.urlString = HomePage_URL;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:clvc];
    
    MenuViewController *menuLeft = [[MenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nc
                                                                    leftMenuViewController:menuLeft
                                                                   rightMenuViewController:nil];
    
    
    
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Dark_Comment_Line.png"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.5;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    sideMenuViewController.scaleContentView = YES;
    
    self.window.rootViewController = sideMenuViewController;
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
}

@end
