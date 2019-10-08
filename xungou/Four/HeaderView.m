//
//  HeaderView.m
//  wode
//
//  Created by chenlishuang on 16/12/2.
//  Copyright © 2016年 chenlishuang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
    if (userName.length > 0) {
        if ([userName isEqualToString:@"123456"]) {
            self.nameLabel.text = @"测试账号";
        }else{
            self.nameLabel.text = userName;
        }
    }
}

@end
