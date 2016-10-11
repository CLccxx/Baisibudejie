//
//  CLMeSquareButton.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/26.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMeSquareButton.h"
#import "CLMeSquare.h"
#import <UIButton+WebCache.h>

@implementation CLMeSquareButton

-(void)setSquare:(CLMeSquare *)square
{
    // 通过bubtton 的属性 square的set方法，拿到square后给button的图片和文字赋值 。
    _square = square;
    // 设置所有button的图片和文字
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"header_cry_icon"]];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 如果没有提供图片我们可以设置buton width height 分别减1;
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 修改button 内imageView 和 label的位置
    self.imageView.cl_y = self.cl_height * 0.15;
    self.imageView.cl_width = self.cl_width * 0.5;
    self.imageView.cl_height = self.imageView.cl_width;
    self.imageView.cl_centerX = self.cl_width * 0.5;
    
    self.titleLabel.cl_x = 0;
    self.titleLabel.cl_y = self.imageView.cl_bottom;
    self.titleLabel.cl_width = self.cl_width;
    self.titleLabel.cl_height = self.cl_height - self.imageView.cl_bottom;
    
}

@end
