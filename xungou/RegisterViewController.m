//
//  RegisterViewController.m
//  peigou
//
//  Created by Hehe on 2019/9/11.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "RegisterViewController.h"
#import "BaseTabBarController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)registerAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.phoneTF.text.length == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填您的账号";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.pwdTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写密码";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.pwdTF.text.length < 6){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码不能少于6位";
        [hud hide:YES afterDelay:2];
        return;
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"注册成功";
    [hud hide:YES afterDelay:2];
    [[NSUserDefaults standardUserDefaults] setValue:self.phoneTF.text forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setValue:self.pwdTF.text forKey:kPassword];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController  = [BaseTabBarController new];
    });
}
- (IBAction)gotoLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
