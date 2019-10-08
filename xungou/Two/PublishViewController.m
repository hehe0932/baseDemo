//
//  PublishViewController.m
//  peigou
//
//  Created by Hehe on 2019/8/30.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishDetailViewController.h"
@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}
- (IBAction)femaleAction:(id)sender {
    PublishDetailViewController *vc = [[PublishDetailViewController alloc]init];
    vc.gender = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)maleAction:(id)sender {
    PublishDetailViewController *vc = [[PublishDetailViewController alloc]init];
    vc.gender = 1;
    [self.navigationController pushViewController:vc animated:YES];
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
