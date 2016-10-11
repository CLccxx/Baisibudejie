//
//  CLComposeVC.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLComposeVC.h"
#import "CLMenuItem.h"
#import "CLItemBtn.h"

@interface CLComposeVC ()

@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,assign)int btnNum;
@property(nonatomic,strong)NSTimer *time;

@end

@implementation CLComposeVC

-(NSMutableArray *)btnArr
{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBtn];
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(upData) userInfo:nil repeats:YES];
}

-(void)upData
{
    if (self.btnNum == self.btnArr.count) {
        [self.time invalidate];
        return;
    }
    UIButton *btn = self.btnArr[self.btnNum];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    self.btnNum ++;
//    [UIView animateWithDuration:0.5 animations:^{
//        for (UIButton *btn in self.btnArr) {
//            btn.transform = CGAffineTransformIdentity;
//        }
//    }];
//    NSLog(@"%s",__func__);
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        for (UIButton *btn in self.btnArr) {
//            btn.transform = CGAffineTransformIdentity;
//        }
//    }];
//}



-(void)addBtn
{
    CGFloat btnWH = 100;
    int cloumn = 3;
    int curCloumn = 0;
    int curRow = 0;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width- cloumn * btnWH)/(cloumn + 1);
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat oriY = 300;
    
    CLMenuItem *item = [[CLMenuItem  alloc]init];
    
    for (int i = 0 ; i < self.itemArr.count; i++) {
        CLItemBtn *btn = [CLItemBtn buttonWithType:UIButtonTypeCustom];
        curCloumn = i % cloumn;
        curRow = i / cloumn;
        
        x = margin + curCloumn * (btnWH + margin);
        y = curRow * (btnWH +margin) + oriY;
        
        btn.frame = CGRectMake(x,y, btnWH, btnWH);
        item = self.itemArr[i];
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClickT:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArr addObject:btn];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}
-(void)btnClickT:(UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 0;
        btn.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (IBAction)cancleBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
