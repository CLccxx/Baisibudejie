//
//  UIImage+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/7.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "UIImage+CLExtension.h"

@implementation UIImage (CLExtension)

/** 返回圆形图片 */
-(instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/** 直接根据image name设置圆角 */
+(instancetype)circleImageNamed:(NSString *)name
{
    return [[UIImage imageNamed:name] circleImage];
}

@end
