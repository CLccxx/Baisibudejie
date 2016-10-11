//
//  CLEssenceViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLEssenceViewController.h"
#import "CLTitleButton.h"
#import "CLAllViewController.h"
#import "CLVideoViewController.h"
#import "CLVoiceViewController.h"
#import "CLWordViewController.h"
#import "CLPictureViewController.h"
#import "CLRecommendTagViewController.h"

@interface CLEssenceViewController ()<UIScrollViewDelegate>

// 选中按钮
@property(nonatomic,weak) CLTitleButton *selectedButton;

// 底部指示条
@property(nonatomic,weak) UIView *indicatorView;

// scrollView
@property(nonatomic,weak) UIScrollView *scrollView;

// 标题栏
@property(nonatomic,weak) UIView *titlesView;

@end

@implementation CLEssenceViewController

-(void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNav];
    [self setUpChildViewController];
    [self setUpScrollView];
    [self setUpTitlesView];
    [self addChildVcView];
}

-(void)setUpChildViewController
{
    CLAllViewController *all = [[CLAllViewController alloc]init];
    [self addChildViewController:all];
    CLVideoViewController *video = [[CLVideoViewController alloc]init];
    [self addChildViewController:video];
    CLVoiceViewController *voice = [[CLVoiceViewController alloc]init];
    [self addChildViewController:voice];
    CLPictureViewController *picture = [[CLPictureViewController alloc]init];
    [self addChildViewController:picture];
    CLWordViewController *word = [[CLWordViewController alloc]init];
    [self addChildViewController:word];
}

// 添加子控制器
-(void)addChildVcView
{
    int index = self.scrollView.contentOffset.x / self.scrollView.cl_width;
    UIViewController *childVc = self.childViewControllers[index];
//    childVc.view.frame = CGRectMake(index * self.scrollView.cl_width, 0, self.scrollView.cl_width, self.scrollView.cl_height);
    //可以化简成一句代码
    
    childVc.view.frame = self.scrollView.bounds;
    
    [self.scrollView addSubview:childVc.view];
    
}
// 设置scrollView
-(void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = CLCommonColor(206);
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    NSInteger count = [self.childViewControllers count];
//    for (int i = 0; i < count; i ++) {
//        UITableView *childVcView = (UITableView *)self.childViewControllers[i].view;
//        childVcView.frame = CGRectMake(self.view.cl_width * i, 0, self.view.cl_width, self.view.cl_height);
//        childVcView.backgroundColor = CLRandomColor;
//
//        childVcView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
//        // 设置tableView内 滑动条的内边距
//        childVcView.scrollIndicatorInsets = childVcView.contentInset;
//        [scrollView addSubview:childVcView];
//    }
    scrollView.contentSize = CGSizeMake(self.view.cl_width * count, 0);
    scrollView.delegate = self;
    self.scrollView = scrollView;
}

// 设置标题view
-(void)setUpTitlesView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.cl_width, 35)];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    self.titlesView = titleView;
    
    CGFloat buttonW = titleView.cl_width / 5.0;
    CGFloat buttonH = titleView.cl_height;

    NSArray *titlesArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = [titlesArr count];
    for (int i= 0; i < count ; i ++) {
        CLTitleButton *titleButton = [CLTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [titleButton setTitle:titlesArr[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
    }
    [self.view addSubview:titleView];
    UIView *indicatorView = [[UIView alloc]init];
    // 也可以取出button selecter状态下的颜色
//    UIButton *button = titleView.subviews.lastObject;
//    indicatorView.backgroundColor = [button titleColorForState:UIControlStateSelected];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.cl_height = 2;
    indicatorView.cl_y = titleView.cl_height - 2;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    // 不想要动画
    CLTitleButton *button = titleView.subviews.firstObject;
    [button.titleLabel sizeToFit];
    button.selected = YES;
    self.selectedButton = button;
    indicatorView.cl_width = button.titleLabel.cl_width + 6;
    indicatorView.cl_centerX = button.cl_centerX;
}

// 标题button点击事件
-(void)titleClick:(CLTitleButton *)button
{
    // 某个标题按钮被重复点击了
    if (button == self.selectedButton) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:CLTitleButtonDidRepeatClickNotification object:nil];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 获取button title 的宽度
    // CGFloat titleW = [button.currentTitle sizeWithFont:button.titleLabel.font].width;
    // CGFloat titleW = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.cl_width = button.titleLabel.cl_width + 6;
        self.indicatorView.cl_centerX = button.cl_centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.view.cl_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

// 设置导航栏内容
-(void)setUpNav
{
    // 设置View背景颜色
    self.view.backgroundColor = CLCommonColor(206);
    // 设置标题图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置左边按钮button
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" HeightImage:@"MainTagSubIconClick" Target:self action:@selector(leftBtnClick)];
}
// 导航栏左边按钮点击事件
-(void)leftBtnClick
{
    CLRecommendTagViewController *recommend = [[CLRecommendTagViewController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
    
    CLLog(@"----");
}

#pragma mark UIScrollViewDelegate代理方法

// 滑动结束时，一定要调用[setcontentoffset animated ] 或者 [scrollerRactVisible animaated]方法让scroll产生滚动动画，动画结束时才会调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

// 减速完成 也就是滑动完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中 点击对应的按钮
    int index = scrollView.contentOffset.x / scrollView.cl_width;
    // 添加子控制器
    [self addChildVcView];
    CLTitleButton *button = self.titlesView.subviews[index];
    [self titleClick:button];
}

@end
