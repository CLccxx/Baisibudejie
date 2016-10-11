//
//  CLMeSquareButton.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/26.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLMeSquare;
@interface CLMeSquareButton : UIButton

// 为button绑定一个模型属性
@property(nonatomic,strong)CLMeSquare *square;

@end
