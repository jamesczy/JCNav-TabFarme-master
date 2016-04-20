//
//  AppDelegate.m
//  JCNav-TabFarme
//
//  Created by yingyi on 15/9/22.
//  Copyright (c) 2015年 yingyi. All rights reserved.
//

#import "AppDelegate.h"
#import "JCTabBarViewController.h"

#import "JCDownloadViewController.h"
#import "JCLocalVideoController.h"
#import "DEMOLeftMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    JCTabBarViewController *jcTabBarViewController = [[JCTabBarViewController alloc]init];
    
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:jcTabBarViewController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = sideMenuViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

//回调打开应用
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
////    NSString *receText = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *receText = [[url host] stringByRemovingPercentEncoding];
//    NSLog(@"%@    %@",receText, url.absoluteString);
//    
//    
//    [self performSelector:@selector(goBackToApp1) withObject:nil afterDelay:2];
//    
//    return YES;
//    
//}
//
//- (void)goBackToApp1 {
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"TEST1://"]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"TEST1://paySuccess=1"]];
//    }
//}

@end
