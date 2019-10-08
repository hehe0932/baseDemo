//
//  TShehe.h
//  kyyg-iOS
//
//  Created by tiens on 2018/6/27.
//  Copyright © 2018年 com.tiens.kyyg-iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAlertManager : NSObject
/** 带取消的弹框 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message handle:(void (^)(UIAlertAction *action))handler;
/** 不带取消的弹框 */
+ (void)alertWithNoCancelTitle:(NSString *)title message:(NSString *)message handle:(void (^)(UIAlertAction *action))handler;
/** 指定控制器的弹窗 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message vc:(UIViewController *)vc handle:(void (^)(UIAlertAction *action))handler;
@end
