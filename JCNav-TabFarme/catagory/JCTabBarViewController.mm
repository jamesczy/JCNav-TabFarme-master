//
//  JCTabBarViewController.m
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCTabBarViewController.h"
#import "JCNavigationController.h"
#import "JCConst.h"
//#import "ViewController.h"
#import "JCOnlineViewController.h"
#import "JCDownloadViewController.h"
#import "JCInfoController.h"
#import "JCCellController.h"
//#import "JCTabBar.h"
//
//@interface JCTabBarViewController ()<JCTabBarDelegate>
//
//@end

@implementation JCTabBarViewController


-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JCColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:37/255.0 green:129/255.0 blue:285/255.0 alpha:1];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

    //先把外面传进来的控制器包装一个导航器
    UINavigationController *nav = [[JCNavigationController alloc]initWithRootViewController:childVc];
    //添加自控制器
    [self addChildViewController:nav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    JCCellController *home = [[JCCellController alloc]init];
    [self addChildVc:[[JCCellController alloc]init] title:@"首页" image:@"主页黑色" selectedImage:@"主页蓝色"];

//    JCOnlineViewController *onLine =[[JCOnlineViewController alloc]init];
    [self addChildVc:[[JCOnlineViewController alloc]init] title:@"视频" image:@"视频黑色" selectedImage:@"视频蓝色"];
    
//    JCDownloadViewController *downLoad = [[JCDownloadViewController alloc]init];
    [self addChildVc:[[JCDownloadViewController alloc]init] title:@"下载" image:@"下载黑色" selectedImage:@"下载蓝色"];
    
//    JCInfoController *info = [[JCInfoController alloc]init];
    [self addChildVc:[[JCInfoController alloc]init] title:@"个人" image:@"个人黑色" selectedImage:@"个人蓝色"];
    

}


@end
