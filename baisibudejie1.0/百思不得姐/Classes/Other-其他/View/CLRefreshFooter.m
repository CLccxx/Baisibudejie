//
//  CLRefreshFooter.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/2.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLRefreshFooter.h"

@implementation CLRefreshFooter


- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
//    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
    //    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    //    self.automaticallyRefresh = NO;
}

@end
