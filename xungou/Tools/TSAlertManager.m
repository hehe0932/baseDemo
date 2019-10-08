//
//  TShehe.m
//  kyyg-iOS
//
//  Created by tiens on 2018/6/27.
//  Copyright © 2018年 com.tiens.kyyg-iOS. All rights reserved.
//

#import "TSAlertManager.h"

@implementation TSAlertManager
/** 带取消的弹框 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message handle:(void (^)(UIAlertAction *))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
//    [sureAction setValue:AppMainColor() forKey:@"titleTextColor"];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [cancleAction setValue:AppText_grayColor() forKey:@"titleTextColor"];
    [sameAlertC addAction:sureAction];
    [sameAlertC addAction:cancleAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:sameAlertC animated:YES completion:nil];
}

/** 不带取消的弹框 */
+ (void)alertWithNoCancelTitle:(NSString *)title message:(NSString *)message handle:(void (^)(UIAlertAction *action))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
//    [sureAction setValue:AppMainColor() forKey:@"titleTextColor"];
    [sameAlertC addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:sameAlertC animated:YES completion:nil];
}

/** 指定控制器的弹窗 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message vc:(UIViewController *)vc handle:(void (^)(UIAlertAction *action))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
//    [sureAction setValue:AppMainColor() forKey:@"titleTextColor"];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [cancleAction setValue:AppText_grayColor() forKey:@"titleTextColor"];
    [sameAlertC addAction:sureAction];
    [sameAlertC addAction:cancleAction];
    [vc presentViewController:sameAlertC animated:YES completion:nil];
}
@end
