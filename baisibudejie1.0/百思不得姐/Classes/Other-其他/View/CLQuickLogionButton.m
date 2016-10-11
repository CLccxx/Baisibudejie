//
//  CLQuickLogionButton.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLQuickLogionButton.h"

@implementation CLQuickLogionButton

// 加载xib都会先走这个方法
-(void)awakeFromNib
{
    [super awakeFromNib];
    // 可以在这里对button进行一些统一的设置
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 修改imageView和titleLabel的位置
    self.imageView.cl_y = 0;
    self.imageView.cl_centerX = self.cl_width*0.5;
    self.titleLabel.cl_x = 0;
    self.titleLabel.cl_width = self.cl_width;
    self.titleLabel.cl_y = self.imageView.cl_height;
    self.titleLabel.cl_height = self.cl_height - self.imageView.cl_height;
}

@end
