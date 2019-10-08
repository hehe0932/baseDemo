//
//  TSToastManager.h
//  alert
//
//  Created by tiens on 2018/6/21.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TSToastType) {
    TSToastTypeNone,
    TSToastTypeGifLoading,
    TSToastTypeIndicator,
    TSToastTypeIndicatorWithText,
    TSToastTypeText,
    TSToastTypeImage,
    TSToastTypeImageWithText
};

@interface TSToastManager : NSObject

/**
 显示gif加载框
 
 @param view 容器view
 @param handler 加载完成回调
 */
+ (void)showGifLoadingTo:(UIView *)view dismissHandler:(void(^)(TSToastManager *toastManager))handler;

/**
 显示只带菊花的加载框
 
 @param view 容器view
 @param handler 加载完成回调
 */
+ (void)showIndicatorTo:(UIView *)view dismissHandler:(void(^)(TSToastManager *toastManager))handler;

/**
 显示带菊花和文字的加载框
 
 @param view 容器view
 @param text 加载文字
 @param handler 加载完成回调
 */
+ (void)showIndicatorTextTo:(UIView *)view withText:(NSString *)text dismissHandler:(void(^)(TSToastManager *toastManager))handler;

/**
 弹出一个只包含文字的提示框
 
 @param view 容器视图
 @param text 提示文字
 @param seconds 消失时间
 */
+ (void)showTextTo:(UIView *)view withText:(NSString *)text dismissAfterr:(NSUInteger)seconds;

/**
 弹出一个只包含图片的提示框
 
 @param view 容器view
 @param img 图片名称
 @param seconds 消失时间
 */
+ (void)showImageTo:(UIView *)view imageName:(NSString *)img dismissAfter:(NSUInteger)seconds;

/**
 弹出一个图片跟文字的提示框
 
 @param view 容器view
 @param img 图片名称
 @param text 提示文字
 @param seconds 消失时间
 */
+ (void)showImageTextTo:(UIView *)view imageName:(NSString *)img withText:(NSString *)text dismisAfter:(NSUInteger)seconds;



/**
 静态方法 隐藏loading状态
 
 @param seconds 动画时间
 */
+ (void)backViewAnimationTime:(NSUInteger)seconds;

/**
 加载完成后隐藏 loading
 */
+ (void)dismissLoading;


/**
 加载立刻完成后隐藏 loading
 */
+ (void)nowDismiss;

@end

@interface TSToastBackView : UIView

/**
 文字提示控件
 */
@property (nonatomic, strong) UILabel *toastLbl;

/**
 黑菊花loading控件
 */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

/**
 图片提示控件
 */
@property (nonatomic, strong) UIImageView *toastImgView;


/**
 gif背景图
 */
@property (nonatomic, strong) UIImageView * loadingImage;

/**
 gif内容图
 */
@property (nonatomic, strong) UIImageView * logoImage;

/**
 容器view
 */
@property (nonatomic, weak) UIView *containerView;


- (void)layoutHUDOnView:(UIView *)view withImage:(NSString *)imgName text:(NSString *)text toastType:(TSToastType)type;

- (void)indicatorAnimationStart;

- (void)indicatorAnimationStop;

- (void)gifloadingAnimationStart;

- (void)gifloadingAnimationStop;

@end






