//
//  BaseNavigationController.m
//  Pocket
//
//  Created by tiens on 2018/8/14.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import "BaseNavigationController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setImage:[UIImage imageNamed:@"left"] forState:(UIControlStateNormal)];
        [button setTitle:@" 返回" forState:UIControlStateNormal];
//        CGFloat spaceW = kScreenWidth == 414?20:16;
        //让按钮内部的所有左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}

@end
