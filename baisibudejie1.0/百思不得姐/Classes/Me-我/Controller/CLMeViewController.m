//
//  CLMeViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMeViewController.h"
#import "CLSettingViewController.h"
#import "CLMeCell.h"
#import "CLMeFooterView.h"

@interface CLMeViewController ()


@end

@implementation CLMeViewController

-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
-(void)viewDidLoad
{
    [self setUpTable];
    [self setUpNav];
}
-(void)setUpTable
{
    // 默认会有一个35的偏移量，如果想让偏移量为10，需要-25,如果为正数会在35的基础上增加，所有的偏移量都会有一个63导航栏的基础
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    // 设置所有cell头标题的高度也可以通过代理方法，逐个设置
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    // 设置View背景颜色
    self.tableView.backgroundColor = CLCommonColor(206);
    // 设置footView
    self.tableView.tableFooterView = [[CLMeFooterView alloc]init];
}

-(void)setUpNav
{
    // 设置标题
    self.navigationItem.title = @"我的";
    // 设置左边按钮button
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" HeightImage:@"mine-setting-icon-click" Target:self action:@selector(settingBtnClick)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" HeightImage:@"mine-moon-icon-click" Target:self action:@selector(MoomBtnClick)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

-(void)settingBtnClick
{
    CLLogfunc;
    CLSettingViewController *settingVC = [[CLSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)MoomBtnClick
{
    CLLogfunc;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    CLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CLMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登陆/注册";
    }else{
        cell.textLabel.text = @"离线下载";
        // 如果有的cell有image有的没有image,需要设置image为nil,因为如果cell重用了,原本没有image的cell也会显示image,所以需要设置为nil,防止cell显示错乱
        cell.imageView.image = nil;
    }
    return cell;
    // 如果image提供的图片较大，我们需要自定义cell,然后重写layoutSubviews来修改布局
}

#pragma mark - UITableViewDelegate

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 2) {
//        return 400;
//    }
//    return 44;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

@end
