//
//  CLConst.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/25.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 通用的间距值 */
CGFloat const CLMargin = 10;
/** 通用的最小间距值 */
CGFloat const CLSmallMargin = CLMargin * 0.5;
/** 通用的api请求 */
NSString * const CLCommonURL = @"http://api.budejie.com/api/api_open.php";

NSString * const CLUserSexMale = @"m";

NSString * const CLUserSexFemale = @"f";

/*** 通知 ***/
/** TabBar按钮被重复点击的通知 */
NSString * const CLTabBarButtonDidRepeatClickNotification = @"CLTabBarButtonDidRepeatClickNotification";
/** 标题按钮被重复点击的通知 */
NSString * const CLTitleButtonDidRepeatClickNotification = @"CLTitleButtonDidRepeatClickNotification";