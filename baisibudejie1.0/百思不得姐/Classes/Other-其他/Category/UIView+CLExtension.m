//
//  UIView+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "UIView+CLExtension.h"

@implementation UIView (CLExtension)

-(void)setCl_size:(CGSize)cl_size
{
    CGRect frame = self.frame;
    frame.size = cl_size;
    self.frame = frame;
}

-(CGSize)cl_size
{
    return self.frame.size;
}

-(void)setCl_width:(CGFloat)cl_width
{
    CGRect frame = self.frame;
    frame.size.width = cl_width;
    self.frame = frame;
}
-(CGFloat)cl_width
{
    return self.frame.size.width;
}

-(void)setCl_height:(CGFloat)cl_height
{
    CGRect frame = self.frame;
    frame.size.height = cl_height;
    self.frame = frame;
}
-(CGFloat)cl_height
{
    return self.frame.size.height;
}
-(void)setCl_x:(CGFloat)cl_x
{
    CGRect frame = self.frame;
    frame.origin.x = cl_x;
    self.frame = frame;
}
-(CGFloat)cl_x
{
    return self.frame.origin.x;
}

-(void)setCl_y:(CGFloat)cl_y
{
    CGRect frame = self.frame;
    frame.origin.y = cl_y;
    self.frame = frame;
}
-(CGFloat)cl_y
{
    return self.frame.origin.y;
}
-(void)setCl_centerX:(CGFloat)cl_centerX
{
    CGPoint center = self.center;
    center.x = cl_centerX;
    self.center = center;
}
-(CGFloat)cl_centerX
{
    return self.center.x;
}
-(void)setCl_centerY:(CGFloat)cl_centerY
{
    CGPoint center = self.center;
    center.y = cl_centerY;
    self.center = center;
}
-(CGFloat)cl_centerY
{
    return self.center.y;
}
-(void)setCl_right:(CGFloat)cl_right
{
    self.cl_x = cl_right - self.cl_width;
}
-(CGFloat)cl_right
{
    return CGRectGetMaxX(self.frame);
}

-(void)setCl_bottom:(CGFloat)cl_bottom
{
    self.cl_y = cl_bottom - self.cl_height;
}
-(CGFloat)cl_bottom
{
    return CGRectGetMaxY(self.frame);
}

+(instancetype)viewFromNib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newRect = [self convertRect:self.bounds toView:window];
    CGRect newView = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(newRect, newView);
}
@end
