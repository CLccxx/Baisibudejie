//
//  CLMeFooterView.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/25.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMeFooterView.h"
#import "CLHTTPSessionManager.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "CLMeSquare.h"
#import "CLMeSquareButton.h"
#import "CLWebViewController.h"
#import <SafariServices/SafariServices.h>
@interface CLMeFooterView ()

// 使用字典来存储一对一的button 和模型，这样当点击button的时候就知道点击的哪个button，我们需要去访问哪个地址
//@property(nonatomic,strong)NSMutableDictionary *squareDict;

// 不使用这种方法也可以，可以绑定模型，为button添加一个属性

@end

@implementation CLMeFooterView

//-(NSMutableDictionary *)squareDict
//{
//    if (_squareDict == nil) {
//        _squareDict = [NSMutableDictionary dictionary];
//    }
//    return _squareDict;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

//        self.cl_height = 600;
//        self.backgroundColor = [UIColor redColor];
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        __weak typeof(self) weakSelf = self;

        [[CLHTTPSessionManager manager]GET:CLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            // 写出plist文件到桌面 便于我们看
//            [responseObject writeToFile:@"/Users/yangboxing/Desktop/me.plist" atomically:YES];
            NSArray *squares = [CLMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [weakSelf createSquare:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            CLLog(@"请求失败");
        }];
    }
    return self;
}

-(void)createSquare:(NSArray *)squares
{
    NSUInteger count = squares.count;
    int maxColsCount = 4;
    CGFloat buttonW = self.cl_width / 4;
    CGFloat buttonH = buttonW;
    for (int i = 0; i < count; i ++) {
        
        CLMeSquare *square = squares[i];
        
        CLMeSquareButton *button =[CLMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.square = square;
        
        // 设置button的frame
        button.cl_x = (i % maxColsCount) * buttonW;
        button.cl_y = (i / maxColsCount) * buttonH;
        button.cl_width = buttonW;
        button.cl_height = buttonH;
        button.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:button];
        
        // description 是控件的类型加内存，这里做为唯一的key来标示模型，如果button的currentTitle是唯一的，我们也可以用currenttitle来作为标示。
//        self.squareDict[button.description] = square;
    }
    self.cl_height = self.subviews.lastObject.cl_bottom;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];  // 重新刷新数据也会重新计算 contentSize 就不会在最后在增加20了。
    
//    tableView.contentSize = CGSizeMake(0, self.cl_bottom);
}

-(void)buttonClick:(CLMeSquareButton *)button
{
//    CLMeSquare *square = self.squareDict[button.description];
    
    CLMeSquare *square = button.square;
    
    
    if ([square.url hasPrefix:@"http"]) {
        
        // 9.0以后可以使用系统的Safari来进行网页加载，只有mode出来的Safari才会显示进度条等控件
//        SFSafariViewController *webView = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:square.url]];
//        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
//        [tabBarVC presentViewController:webView animated:YES completion:nil];
        
        CLWebViewController *webVc = [[CLWebViewController alloc]init];
        webVc.url = square.url;

        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
        UINavigationController *naVC = tabBarVC.selectedViewController;
        webVc.navigationItem.title = square.name;
        [naVC pushViewController:webVc animated:YES];
    }else if ([square.url hasPrefix:@"mod"]){
        CLLog(@"跳转到%@界面",square.url);
    }else{
        CLLog(@"跳转到其他界面");
    }
    
}

@end
