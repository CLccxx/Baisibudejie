//
//  CLItemBtn.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLItemBtn.h"

@implementation CLItemBtn

-(void)awakeFromNib
{
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - imageH;
    CGFloat titleX = imageX;
    CGFloat titleY = imageH;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);

}

// 改变imageView的位置
//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    
//}
// 改变titlelabel的位置
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
