//
//  CLRecommendTag.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/6.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRecommendTag : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
