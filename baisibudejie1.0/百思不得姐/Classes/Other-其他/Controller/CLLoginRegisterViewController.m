//
//  CLLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLLoginRegisterViewController.h"

@interface CLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation CLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loginBtn.layer.cornerRadius = 5;
//    self.loginBtn.layer.masksToBounds = YES;
    
//    [self.loginBtn setValue:@5 forKeyPath:@"layer.cornerRadius"];
//    [self.loginBtn setValue:@YES forKeyPath:@"layer.masksToBunds"];
    
    // xib中设置也可以
}

// 设置状态栏的颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
// 关闭按钮点击事件
- (IBAction)closeBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 空白区域点击也关闭
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLogionOrRegister:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.leftMargin.constant) {
        self.leftMargin.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }else{
        self.leftMargin.constant = -self.view.cl_width;
        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
