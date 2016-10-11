//
//  UITextField+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/24.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "UITextField+CLExtension.h"

static NSString * const CLPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (CLExtension)


-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 提前设置占位文字，让他提前创建placeholderLabel 需要有一个空格，不然起不到作用
    // 防止我们在外面使用的时候 先设置占位文字图片，在设置占位文字。导致占位文字颜色设置失败
    // 需要判断placeholder是否有值，如果没有我们才需要提前去创建 这样做不是太好，有些修改默认
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
        self.placeholder = nil;
    }
    // 我们可以先保留现在的placeholder,当现在的为空的时候，我们先将他保存起来，然后设置为@" "，这时占位文字的颜色也会设置，然后在将占位文字的内容修改回为空，此时即使我们只设置了占位文字颜色，没有设置占位文字，打印占位文字为null
//    NSString *oldplaceholder = self.placeholder;
//    self.placeholder = @" ";
//    self.placeholder = oldplaceholder;
    
    // 恢复到默认颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    [self setValue:placeholderColor forKeyPath:CLPlaceholderColorKey];
    
}
-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:CLPlaceholderColorKey];
}
@end
