//
//  TSToastManager.m
//  alert
//
//  Created by tiens on 2018/6/21.
//  Copyright © 2018年 tiens. All rights reserved.
//

#import "TSToastManager.h"

@interface TSToastManager ()

@property (nonatomic, strong) TSToastBackView *backView;

@property (nonatomic, strong) NSTimer *dismissTimer;

@property (nonatomic, strong) UIView *bgView;
@end

@implementation TSToastManager

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TSToastManager *toastManager;
    _dispatch_once(&onceToken, ^{
        toastManager = [[[self class]alloc]init];
    });
    return toastManager;
}

+ (TSToastManager *)toastManagerInstance {
    return [self sharedInstance];
}

//只显示gifLoading
+ (void)showGifLoadingTo:(UIView *)view dismissHandler:(void (^)(TSToastManager *))handler{
    
    [self showHUDTo:view imageName:nil withText:nil dismissAfter:0 animationType:TSToastTypeGifLoading dismissHandler:handler];

}

//只显示菊花的加载框
+ (void)showIndicatorTo:(UIView *)view dismissHandler:(void(^)(TSToastManager *toastManager))handler {
    
    [self showHUDTo:view imageName:nil withText:nil dismissAfter:0 animationType:TSToastTypeIndicator dismissHandler:handler];
    
}

//显示菊花带文字的加载框
+ (void)showIndicatorTextTo:(UIView *)view withText:(NSString *)text dismissHandler:(void(^)(TSToastManager *toastManager))handler {
    
    [self showHUDTo:view imageName:nil withText:text dismissAfter:0 animationType:TSToastTypeIndicatorWithText dismissHandler:handler];
}

//只显示文字的提示框
+ (void)showTextTo:(UIView *)view withText:(NSString *)text dismissAfterr:(NSUInteger)seconds {
    
    [self showHUDTo:view imageName:nil withText:text dismissAfter:seconds animationType:TSToastTypeText dismissHandler:nil];
    
}

//只显示图片的提示框
+ (void)showImageTo:(UIView *)view imageName:(NSString *)img dismissAfter:(NSUInteger)seconds {
    
    [self showHUDTo:view imageName:img withText:nil dismissAfter:seconds animationType:TSToastTypeImage dismissHandler:nil];
    
}

//显示图片带文字的提示框
+ (void)showImageTextTo:(UIView *)view imageName:(NSString *)img withText:(NSString *)text dismisAfter:(NSUInteger)seconds{
    
    [self showHUDTo:view imageName:img withText:text dismissAfter:seconds animationType:TSToastTypeImageWithText dismissHandler:nil];
    
}


+ (void)showHUDTo:(UIView *)view imageName:(NSString *)img withText:(NSString *)text dismissAfter:(NSUInteger)seconds animationType:(TSToastType)type dismissHandler:(void(^)(TSToastManager *toastManager))handler {

    [self nowDismiss];
    
    [[self toastManagerInstance].backView layoutHUDOnView:view withImage:img text:text toastType:type];
    [[UIApplication sharedApplication].keyWindow addSubview:[self toastManagerInstance].bgView];
    [self animationType:type dismissHandler:handler];
    
    if (type == TSToastTypeText || type == TSToastTypeImage || type == TSToastTypeImageWithText) {
        [[self toastManagerInstance].bgView removeFromSuperview];
        [self dismissAfter:seconds];
    }
    
}

+ (void)animationType:(TSToastType)type dismissHandler:(void(^)(TSToastManager *toastManager))handler {
    
    //cancel previous dismissing
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismissPreviousAnimationView) target:self argument:nil];
    
    [self toastManagerInstance].backView.alpha = 0;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [self toastManagerInstance].backView.alpha = 1;
        if (type == TSToastTypeIndicatorWithText || type == TSToastTypeIndicator) {
            [[self toastManagerInstance].backView indicatorAnimationStart];
        }
        
        if (type == TSToastTypeGifLoading) {
            [[self toastManagerInstance].backView gifloadingAnimationStart];
        }
        
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            if (handler) {
                handler([self toastManagerInstance]);
            }
        }
    }];
}

#pragma mark - cancel previous dismissing
+ (void)dismissPreviousAnimationView {
    
    [self backViewAnimationTime:1];
    
}

#pragma mark - timer dismiss
+ (void)dismissAfter:(NSUInteger)seconds {
    [self setDismissTimerWithInterval:seconds];
    
}

+ (void)setDismissTimerWithInterval:(NSUInteger)seconds {
    
    [[self toastManagerInstance].dismissTimer invalidate];
    [self toastManagerInstance].dismissTimer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:seconds] interval:1 target:self selector:@selector(dismiss:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:[self toastManagerInstance].dismissTimer forMode:NSRunLoopCommonModes];
    
}

+ (void)dismiss:(NSTimer *)timer {
    [self backViewAnimationTime:0.3];
}

#pragma mark - dismiss animation
+ (void)backViewAnimationTime:(NSUInteger)seconds {
    
    [[self toastManagerInstance].dismissTimer invalidate];
    [self toastManagerInstance].dismissTimer = nil;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    [self toastManagerInstance].backView.alpha = 0.02f;
    [UIView commitAnimations];

}

+ (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [[self toastManagerInstance].backView removeFromSuperview];
    [[self toastManagerInstance].bgView removeFromSuperview];
    [self toastManagerInstance].backView = nil;
}

+ (void)dismissLoading {
    [TSToastManager backViewAnimationTime:0.0];
}

+ (void)nowDismiss{
    
    [[self toastManagerInstance].dismissTimer invalidate];
    [self toastManagerInstance].dismissTimer = nil;
    [self toastManagerInstance].backView.alpha = 0.02f;
    [[self toastManagerInstance].backView removeFromSuperview];
    [[self toastManagerInstance].bgView removeFromSuperview];
    [self toastManagerInstance].backView = nil;
}


#pragma mark - getter
- (TSToastBackView *)backView {
    if (!_backView) {
        _backView = [[TSToastBackView alloc]init];
    }
    return _backView;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.alpha = 0.3;
        _bgView.backgroundColor = [UIColor blackColor];

    }
    return _bgView;
}

@end



@interface TSToastBackView ()


@property (nonatomic, assign) TSToastType toastType;

@end

@implementation TSToastBackView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.opaque = NO;
        self.layer.cornerRadius = 4;
        self.layer.shadowOpacity = 0.6;// 阴影透明度
        self.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
        self.layer.shadowRadius = 3;// 阴影扩散的范围控制
        self.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围
        [self addSubview:self.indicatorView];
        [self addSubview:self.toastLbl];
        [self addSubview:self.toastImgView];
        [self addSubview:self.logoImage];
        [self addSubview:self.loadingImage];
    }
    return self;
}

#pragma mark - getter
- (UILabel *)toastLbl {
    if (!_toastLbl) {
        _toastLbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 10)];
        _toastLbl.font = [UIFont systemFontOfSize:14];
        _toastLbl.numberOfLines = 0;
        _toastLbl.textAlignment = NSTextAlignmentCenter;
        _toastLbl.textColor = [UIColor whiteColor];
    }
    return _toastLbl;
}

- (UIImageView *)toastImgView {
    if (!_toastImgView) {
        _toastImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    }
    return _toastImgView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_indicatorView setFrame:CGRectMake(0, 0, 40, 40)];
    }
    return _indicatorView;
}

- (UIImageView *)loadingImage{
    if (!_loadingImage) {
        _loadingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    }
    return _loadingImage;
}

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_loading"]];
    }
    return _logoImage;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.toastType == TSToastTypeIndicator) {
        [self.toastImgView setHidden:YES];
        [self.toastLbl setHidden:YES];
        [self.indicatorView setHidden:NO];
        [self.logoImage setHidden:YES];
        [self.loadingImage setHidden:YES];
        [self setFrame:CGRectMake(0, 0, 60, 60)];
        [self setCenter:CGPointMake(self.containerView.bounds.size.width/2, self.containerView.bounds.size.height/2)];
        self.indicatorView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    
    if (self.toastType == TSToastTypeIndicatorWithText) {
        [self.toastImgView setHidden:YES];
        [self.toastLbl setHidden:NO];
        [self.indicatorView setHidden:NO];
        [self.logoImage setHidden:YES];
        [self.loadingImage setHidden:YES];
        CGRect toastLblRect = self.toastLbl.frame;
        [self setFrame:CGRectMake(0, 0, CGRectGetWidth(toastLblRect) + 20, CGRectGetHeight(toastLblRect) + CGRectGetHeight(self.indicatorView.frame) + 25)];
        [self setCenter:CGPointMake(CGRectGetWidth(self.containerView.frame)/2, CGRectGetHeight(self.containerView.frame)/2)];
        [self.indicatorView setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.indicatorView.frame)/2 + 10)];
        [self.toastLbl setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 10 - CGRectGetHeight(self.toastLbl.frame)/2)];
    }
    
    if (self.toastType == TSToastTypeText) {
        [self.toastImgView setHidden:YES];
        [self.toastLbl setHidden:NO];
        [self.indicatorView setHidden:YES];
        [self.logoImage setHidden:YES];
        [self.loadingImage setHidden:YES];
        CGRect toastLblRect = self.toastLbl.frame;
        [self setFrame:CGRectMake(0, 0, CGRectGetWidth(toastLblRect) + 26, CGRectGetHeight(toastLblRect) + 26)];
        [self setCenter:CGPointMake(CGRectGetWidth(self.containerView.frame)/2, CGRectGetHeight(self.containerView.frame)/2)];
        [self.toastLbl setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
    }
    
    if (self.toastType == TSToastTypeImage) {
        [self.toastImgView setHidden:NO];
        [self.toastLbl setHidden:YES];
        [self.indicatorView setHidden:YES];
        [self.logoImage setHidden:YES];
        [self.loadingImage setHidden:YES];
        [self setFrame:CGRectMake(0, 0, CGRectGetWidth(self.toastImgView.frame) + 30, CGRectGetHeight(self.toastImgView.frame) + 30)];
        [self setCenter:CGPointMake(CGRectGetWidth(self.containerView.frame)/2, CGRectGetHeight(self.containerView.frame)/2)];
        [self.toastImgView setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
    }
    
    if (self.toastType == TSToastTypeImageWithText) {
        [self.toastImgView setHidden:NO];
        [self.toastLbl setHidden:NO];
        [self.indicatorView setHidden:YES];
        [self.logoImage setHidden:YES];
        [self.loadingImage setHidden:YES];
        CGRect toastLblRect = self.toastLbl.frame;
        [self setFrame:CGRectMake(0, 0, (CGRectGetWidth(toastLblRect) > CGRectGetWidth(self.toastImgView.frame)) ? CGRectGetWidth(toastLblRect) +20 : CGRectGetWidth(self.toastImgView.frame) + 20, CGRectGetHeight(toastLblRect) + CGRectGetHeight(self.toastImgView.frame) + 30)];
        [self setCenter:CGPointMake(CGRectGetWidth(self.containerView.frame)/2, CGRectGetHeight(self.containerView.frame)/2)];
        [self.toastImgView setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.toastImgView.frame)/2 + 10)];
        [self.toastLbl setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 10 - CGRectGetHeight(self.toastLbl.frame)/2)];
    }
    
    if (self.toastType == TSToastTypeGifLoading) {
        [self.toastImgView setHidden:YES];
        [self.toastLbl setHidden:YES];
        [self.indicatorView setHidden:YES];
        [self.logoImage setHidden:NO];
        [self.loadingImage setHidden:NO];
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = [UIColor clearColor].CGColor;// 阴影的颜色
        [self setFrame:CGRectMake(0, 0, 100, 100)];
        [self setCenter:CGPointMake(self.containerView.bounds.size.width/2, self.containerView.bounds.size.height/2)];
        self.logoImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.loadingImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    
}

- (void)layoutHUDOnView:(UIView *)view withImage:(NSString *)imgName text:(NSString *)text toastType:(TSToastType)type {
    
    //默认设置lbl的最大宽度
    [self.toastLbl setFrame:CGRectMake(50, 50, 200, 10)];
    
    self.toastType = type;
    
    self.containerView = view;
    
    [self.containerView addSubview:self];
    
    if (imgName) {
        self.toastImgView.image = [UIImage imageNamed:imgName];
    }
    
    if (text) {
        self.toastLbl.text = text;
        [self.toastLbl sizeToFit];
    }
    
    if (self.toastType == TSToastTypeIndicator || self.toastType == TSToastTypeIndicatorWithText) {
        [self.indicatorView startAnimating];
    }
    
    if (self.toastType == TSToastTypeGifLoading) {
        [self gifloadingAnimationStart];
    }
    
    [self setNeedsLayout];
    
}

- (void)indicatorAnimationStart {
    [self.indicatorView startAnimating];
}

- (void)indicatorAnimationStop{
    [self.indicatorView stopAnimating];
}

- (void)gifloadingAnimationStart{
     CAAnimation *animation = [self.loadingImage.layer animationForKey:@"rotationAnimation"];
    
    if (!animation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:M_PI*2];
        animation.duration  = 0.5;
        animation.autoreverses = NO;
        animation.removedOnCompletion = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT;
        [self.loadingImage.layer addAnimation:animation forKey:@"loading"];
    }
    
}

- (void)gifloadingAnimationStop{
    [self.loadingImage.layer removeAnimationForKey:@"loading"];
}




@end
