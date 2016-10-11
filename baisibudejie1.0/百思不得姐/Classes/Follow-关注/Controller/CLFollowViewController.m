//
//  CLFollowViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLFollowViewController.h"
#import "CLLoginRegisterViewController.h"

@implementation CLFollowViewController

-(void)viewDidLoad
{
    // 设置View背景颜色
    self.view.backgroundColor = CLCommonColor(206);
    
    // 设置标题
    self.navigationItem.title = @"我的关注";
    // 设置左边按钮button
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" HeightImage:@"friendsRecommentIcon-click" Target:self action:@selector(leftBtnClick)];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
//    [leftBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
//    [leftBtn sizeToFit];
//    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (IBAction)loginButtonAction {
    
    CLLoginRegisterViewController  *loginRegisterVC = [[CLLoginRegisterViewController alloc]init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
}


-(void)leftBtnClick
{
    CLLogfunc;
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = CLRandomColor;
    [vc.navigationController hidesBottomBarWhenPushed];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
