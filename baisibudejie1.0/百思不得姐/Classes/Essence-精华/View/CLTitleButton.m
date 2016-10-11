//
//  CLTitleButton.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/29.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTitleButton.h"

@implementation CLTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end
