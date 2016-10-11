//
//  CLWebViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/26.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLWebViewController.h"

@interface CLWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)refresh:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
