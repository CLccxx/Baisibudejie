//
//  CLRecommendTagViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/6.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLRecommendTagViewController.h"
#import "CLRecommendTagCell.h"
#import "CLHTTPSessionManager.h"
#import "CLRecommendTag.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
@interface CLRecommendTagViewController ()

@property(nonatomic,strong)CLHTTPSessionManager *manager;
@property(nonatomic,strong)NSArray<CLRecommendTag *> *recommendTags;

@end

@implementation CLRecommendTagViewController

static NSString * const RecommendTagCellID = @"recommendTag";

/** manager属性的懒加载 */
-(CLHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [CLHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CLRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:RecommendTagCellID];
    
    self.navigationItem.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CLCommonColor(206);
    
    [self loadNewRecommandTags];

}

- (void)loadNewRecommandTags
{
    [SVProgressHUD show];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // block中最好使用弱引用，防止内部强引用控件，使其该销毁的时候不销毁
    __weak typeof(self) weakSelf = self;
    [self.manager GET:CLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        CLWriteToPlist(responseObject, @"biaoqian.plist");
        
//        [NSThread sleepForTimeInterval:10];
        
        // 请求成功
        weakSelf.recommendTags = [CLRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 请求成功之后一定记得刷新界面
        [weakSelf.tableView reloadData];
        // 取出SVP
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果是取消任务, 就直接返回,因为取消请求是有可能返回到这个方法内部的
        if (error.code == NSURLErrorCancelled) return;
        // 最好先关闭之前的提醒重新提醒用户
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 控制器消失就隐藏HUD
    [SVProgressHUD dismiss];
    // 取消请求
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 直接取消task的所有请求，并且以后也不在进行请求
    [self.manager invalidateSessionCancelingTasks:YES];
}

-(void)dealloc
{
    CLLogfunc
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTagCellID];
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}

@end
