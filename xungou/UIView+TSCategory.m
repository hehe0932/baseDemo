//
//  UIView+TSCategory.m
//  Pocket
//
//  Created by tiens on 2018/8/17.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import "UIView+TSCategory.h"

#define border_Color UIColor.light.CGColor;

@implementation UIView (TSCategory)

- (void)addBottomLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size {
    CALayer *layer = [CALayer layer];
    [layer setFrame:CGRectMake(inset.left, size.height - 1, size.width - fabs(inset.left) - fabs(inset.right), 1)];
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
}

- (void)addTopLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size {
    
    CALayer *layer = [CALayer layer];
    [layer setFrame:CGRectMake(inset.left, 0, size.width - fabs(inset.left) - fabs(inset.right), 1)];
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
    
}

- (void)addLeftLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size {
    
    CALayer *layer = [CALayer layer];
    [layer setFrame:CGRectMake(0, fabs(inset.top), 1, size.height - fabs(inset.top) - fabs(inset.bottom))];
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
    
}
- (void)addRightLineWithEdge:(UIEdgeInsets)inset viewSize:(CGSize)size {
    CALayer *layer = [CALayer layer];
    [layer setFrame:CGRectMake(size.width - 1, fabs(inset.top), 1, size.height - fabs(inset.top) - fabs(inset.bottom))];
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
}

+ (instancetype)viewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}
@end
