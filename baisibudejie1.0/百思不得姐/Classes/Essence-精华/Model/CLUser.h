//
//  CLUser.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/4.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end
