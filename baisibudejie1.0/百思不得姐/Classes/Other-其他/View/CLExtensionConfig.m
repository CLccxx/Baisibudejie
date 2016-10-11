//
//  CLExtensionConfig.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/4.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLExtensionConfig.h"
#import <MJExtension.h>
#import "CLTopic.h"
#import "CLComment.h"
@implementation CLExtensionConfig


+(void)load
{
    [CLTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        // 将返回数据中的 image0 转化为模型中的small_image
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
        
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}

@end
