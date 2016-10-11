//
//  UIImageView+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/7.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "UIImageView+CLExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (CLExtension)


/** 默认为圆形头像 */
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}
/** 设置圆形头像 */
- (void)setCircleHeader:(NSString *)url
{
       // 将占位图片也转化为圆形 其实占位图片本来就是圆形
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 如果image为空则返回占位图片
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];
}
/** 设置方形头像 */
- (void)setRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}
@end
