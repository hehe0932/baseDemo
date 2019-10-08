//
//  BaseTabBarController.m
//  Pocket
//
//  Created by tiens on 2018/8/13.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import "BaseTabBarController.h"
#import "OneViewController.h"
#import "PublishViewController.h"
#import "PersonCenterController.h"
#import "BaseNavigationController.h"
#import "LastViewController.h"
@interface BaseTabBarController ()
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    OneViewController *oneVC = [[OneViewController alloc]init];
    [self addviewController:oneVC withTitle:@"首页" normalImage:@"首页(1)" selectedImage:@"首页"];
    
    PublishViewController *twoVC = [[PublishViewController alloc]init];
    [self addviewController:twoVC withTitle:@"发布" normalImage:@"发布(1)" selectedImage:@"发布"];
    
    LastViewController *threeVC = [[LastViewController alloc]init];
    [self addviewController:threeVC withTitle:@"动态" normalImage:@"聊天(1)" selectedImage:@"聊天"];

    PersonCenterController *fiveVC = [[PersonCenterController alloc]init];
    [self addviewController:fiveVC withTitle:@"我的" normalImage:@"我的(1)" selectedImage:@"我的"];
    self.tabBar.tintColor = [UIColor orangeColor];
}

- (void)addviewController:(UIViewController *)viewController withTitle:(NSString *)title normalImage:(NSString *)normalImageName selectedImage:(NSString *)selectedImageName {
    //设置title
    viewController.title = title;
    //设置默认item图片
    viewController.tabBarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选择后的图标
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:viewController];
    nav.navigationBar.barTintColor = [UIColor orangeColor];
    [self addChildViewController:nav];
}



@end
