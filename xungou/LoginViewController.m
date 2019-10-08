//
//  LoginViewController.m
//  peigou
//
//  Created by Hehe on 2019/9/3.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseTabBarController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.phoneTF.text.length == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填您的账号";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.passwordTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写密码";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.passwordTF.text.length < 6){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码不能少于6位";
        [hud hide:YES afterDelay:2];
        return;
    }

    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"登录成功";
    [hud hide:YES afterDelay:2];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.phoneTF.text forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setValue:self.passwordTF.text forKey:kPassword];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController  = [BaseTabBarController new];
    });
}


- (IBAction)gotoRegister:(id)sender {
    RegisterViewController *vc=[[RegisterViewController alloc]init];
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
