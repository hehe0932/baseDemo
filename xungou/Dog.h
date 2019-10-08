//
//  Dog.h
//  peigou
//
//  Created by Hehe on 2019/9/20.
//  Copyright © 2019 shuang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
/** iid */
@property (nonatomic,copy) NSString *iid;
/** 昵称 */
@property (nonatomic,copy) NSString *nickName;
/** 头像 */
@property (nonatomic,copy) NSString *imgUrl;
@end

NS_ASSUME_NONNULL_END
