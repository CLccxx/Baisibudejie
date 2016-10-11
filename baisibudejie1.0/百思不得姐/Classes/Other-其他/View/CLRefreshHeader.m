//
//  CLRefreshHeader.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/1.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLRefreshHeader.h"

@implementation CLRefreshHeader

-(void)prepare
{
    [super prepare];
//    self.automaticallyChangeAlpha = YES;
//    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
//    self.stateLabel.textColor = [UIColor orangeColor];
//    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
//    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
//    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
//    //    self.lastUpdatedTimeLabel.hidden = YES;
//    //    self.stateLabel.hidden = YES;
//    [self addSubview:[[UISwitch alloc] init]];
//    
//    UIImageView *logo = [[UIImageView alloc] init];
//    logo.image = [UIImage imageNamed:@"bd_logo1"];
//    [self addSubview:logo];
//    self.logo = logo;
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];

    
}

@end
