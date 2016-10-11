//
//  CLTopWindow.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/10.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopWindow.h"

@implementation CLTopWindow


static UIWindow *window_;

+(void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        window_ = [[UIWindow alloc]init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        
        window_.backgroundColor = [UIColor clearColor];
        window_.windowLevel = UIWindowLevelAlert;
        window_.hidden = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)];
        [window_ addGestureRecognizer:tap];
        
    });
    
}

+(void)topWindowClick
{
    UIWindow *keiwindow = [UIApplication sharedApplication].keyWindow;
    [self findscrollViewsInView:keiwindow];
}

+(void)findscrollViewsInView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        [self findscrollViewsInView:subview];
    }
    if (![view isKindOfClass:[UIScrollView class]]) return;
    if(![view intersectWithView:[UIApplication sharedApplication].keyWindow])return;
    
    UIScrollView *scrollView = (UIScrollView *)view;
    // 修改offset
    
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    // 这是使scrollView显示出某个区域
    //    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
