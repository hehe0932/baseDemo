//
//  UIView+TSCategory.h
//  Pocket
//
//  Created by tiens on 2018/8/17.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TSCategory)

/**
 为view底部添加一条线
 
 @param inset 上下左右边距 （设置left和right即可）
 @param size view size
 */
- (void)addBottomLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size;

/**
 为view顶部添加一条线
 
 @param inset 上下左右边距 （设置left和right即可）
 @param size view size
 */
- (void)addTopLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size;

/**
 为view左边添加一条线
 
 @param inset 上下左右边距 （设置top和bottom即可）
 @param size  view size
 */
- (void)addLeftLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size;

/**
 为view右边添加一条线
 
 @param inset 上下左右边距 （设置top和bottom即可）
 @param size view size
 */
- (void)addRightLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size;

+ (instancetype)viewFromXib;
@end
