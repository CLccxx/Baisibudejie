//
//  UIView+CLExtension.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CLExtension)

@property(nonatomic,assign)CGFloat cl_width;
@property(nonatomic,assign)CGFloat cl_height;
@property(nonatomic,assign)CGFloat cl_x;
@property(nonatomic,assign)CGFloat cl_y;
@property(nonatomic,assign)CGFloat cl_centerX;
@property(nonatomic,assign)CGFloat cl_centerY;
@property(nonatomic,assign)CGFloat cl_right;
@property(nonatomic,assign)CGFloat cl_bottom;
@property(nonatomic,assign)CGSize cl_size;

+(instancetype)viewFromNib;

-(BOOL)intersectWithView:(UIView *)view;

@end
