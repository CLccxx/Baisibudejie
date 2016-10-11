//
//  CLMenuItem.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMenuItem.h"

@implementation CLMenuItem


+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;
{
    CLMenuItem *item = [[self alloc]init];
    item.title = title;
    item.image = image;
    
    return item;
}


@end
