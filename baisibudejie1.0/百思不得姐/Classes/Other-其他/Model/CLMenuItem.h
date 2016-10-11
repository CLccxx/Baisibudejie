//
//  CLMenuItem.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLMenuItem : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIImage *image;

+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;


@end
