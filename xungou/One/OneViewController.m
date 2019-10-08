//
//  OneViewController.m
//  peigou
//
//  Created by Hehe on 2019/8/29.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "OneViewController.h"
@interface OneViewController ()
@property (nonatomic,strong) UITableView *tableView;
/** 数据 */
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [TSToastManager showGifLoadingTo:self.view dismissHandler:nil];
}

@end
