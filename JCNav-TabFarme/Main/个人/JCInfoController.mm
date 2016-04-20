//
//  JCInfoController.m
//  InstructionExample
//
//  Created by jamesczy on 15/7/27.
//  Copyright (c) 2015年 im360 immersive. All rights reserved.
//  个人中心

#import "JCInfoController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "personalHeaderView.h"
#import "JCNavigationController.h"

@interface JCInfoController ()

@end
static const NSArray * personalArray = @[@"设置",
                                         @"我的视频",
                                         @"观看历史",
                                         @"离线缓存",
                                         @"朋友圈",
                                         @"我的钱包",
                                         @"更多"
                                         ];

static const NSArray *personalImageArray = @[@"设置",
                                             @"我的视频",
                                             @"观看历史",
                                             @"离线缓存",
                                             @"朋友圈",
                                             @"我的钱包",
                                             @"更多"
                                             ];
@implementation JCInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *infoTitleButton = [[UIButton alloc]init];
    infoTitleButton.width = 150;
    infoTitleButton.height =30;
    
    [infoTitleButton setTitle:@"个人中心" forState:UIControlStateNormal];
    [infoTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    infoTitleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.navigationItem.titleView = infoTitleButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navgationleftItem"] style:UIBarButtonItemStyleBordered target:self action:@selector(presentLeftMenuViewController:)];
    personalHeaderView *headerView = [[personalHeaderView alloc]init];
    self.tableView.tableHeaderView = headerView;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
}

#pragma mark -获取屏幕的旋转-
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
//    设置tableheaderview横竖屏的适配
//    NSLog(@"%s",__func__);
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        personalHeaderView *headerView = [[personalHeaderView alloc]init];
        self.tableView.tableHeaderView = headerView;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return personalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = personalArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:personalImageArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.hidesBottomBarWhenPushed = YES;
    UIViewController *VC = [[UIViewController alloc]init];
    VC.title = personalArray[indexPath.row];
    VC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
