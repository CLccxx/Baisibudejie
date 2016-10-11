//
//  CLTabBarController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/20.
//  Copyright © 2016年 xx_cc. All rights reserved.
//


#import "CLTabBarController.h"
#import "CLEssenceViewController.h"
#import "CLNewViewController.h"
#import "CLFollowViewController.h"
#import "CLMeViewController.h"
#import "CLTabBar.h"
#import "CLNavigationController.h"
@interface CLTabBarController ()


@end


@implementation CLTabBarController

#pragma mark 懒加载


-(void)viewDidLoad
{
    /** 设置文字属性 */
    // 设置普通状态下
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 统一设置所有item
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 设置选中状态下
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    [self setUpChildViewWith:[[CLNavigationController alloc] initWithRootViewController:[[CLEssenceViewController alloc]init]]Image:@"tabBar_essence_icon" SelectedImage:@"tabBar_essence_click_icon" Title:@"精华"];
    
    [self setUpChildViewWith:[[CLNavigationController alloc] initWithRootViewController:[[CLNewViewController alloc]init]] Image:@"tabBar_new_icon" SelectedImage:@"tabBar_new_click_icon" Title:@"新帖"];
    
    [self setUpChildViewWith:[[CLNavigationController alloc] initWithRootViewController:[[CLFollowViewController alloc]init]] Image:@"tabBar_friendTrends_icon" SelectedImage:@"tabBar_friendTrends_click_icon" Title:@"关注"];
    
    [self setUpChildViewWith:[[CLNavigationController alloc] initWithRootViewController:[[CLMeViewController alloc]init]] Image:@"tabBar_me_icon" SelectedImage:@"tabBar_me_click_icon" Title:@"我"];

    // 使用KVC替换原来的tabBar
    [self setValue:[[CLTabBar alloc]init]forKeyPath:@"tabBar"];
}


// TabBarController添加子控制器 
-(void)setUpChildViewWith:(UIViewController *)vc Image:(NSString *)image SelectedImage:(NSString *)selectedImage Title:(NSString *)title
{
    vc.tabBarItem.title = title;
    if (image.length) {        
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}


@end
