//
//  FeedbackViewController.m
//  peigou
//
//  Created by Hehe on 2019/9/2.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"联系我们";
}
- (IBAction)submitAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在提交...请稍后";
    [hud hide:YES afterDelay:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self alertWithTitile:@"提示" message:@"提交成功" handle:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
} 
//通用alertController
- (void)alertWithTitile:(NSString *)title message:(NSString *)message handle:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    
    [sameAlertC addAction:sureAction];
    [self presentViewController:sameAlertC animated:YES completion:nil];
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
