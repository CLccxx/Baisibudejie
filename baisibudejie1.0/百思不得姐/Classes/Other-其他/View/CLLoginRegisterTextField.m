//
//  CLLoginRegisterTextField.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/23.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLLoginRegisterTextField.h"
#import <objc/runtime.h>

@interface CLLoginRegisterTextField ()

@property(nonatomic,strong)id observer;

@end
@implementation CLLoginRegisterTextField

-(void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    // 修改占位文字颜色第一种方法
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attributes];
    
    // 修改占位文字颜色第三种方法 运行时+KVC
//     先使用运行时找到私有属性
//    unsigned int count;
//    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i ++) {
//        Ivar ivar = ivarList[i];
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivarList);
    // 使用KVC进行赋值
//    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
//    label.textColor = [UIColor whiteColor];
    
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    self.placeholderColor = [UIColor grayColor];
    
//    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // object:self对象发出UITextFieldTextDidBeginEditingNotification通知就调用 self(监听器)的editingDidBegin方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editingDidBegin) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editingDidEnd) name:UITextFieldTextDidEndEditingNotification object:self];
    
//    // object:self对象发出名字为name的通知，就执行block里面的代码，可以修改block执行的线程，需要保存返回值，等不用的时候释放
//    self.observer = [[NSNotificationCenter defaultCenter]addObserverForName:UITextFieldTextDidBeginEditingNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        
//    }];
    
    //第四种方法
    // 重写UITextField的 becomeFirstResponder 和 resignFirstResponder 方法
    // 成为第一响应者 和 不当第一响应者
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    // 只用block处理监听方法时移除监听
//    [[NSNotificationCenter defaultCenter]removeObserver:self.observer];
}
-(void)editingDidBegin
{
    self.placeholderColor = [UIColor whiteColor];
}
-(void)editingDidEnd
{
    self.placeholderColor = [UIColor grayColor];
}

//// 返回的是占位文字的范围
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    
//}

// 重绘占位文字 修改占位文字颜色第二种方法
//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSFontAttributeName] = self.font;
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    // 从一个起点开始绘画
//    CGPoint placeholderPoint = CGPointMake(0, (self.cl_height - self.font.lineHeight)*0.5);
//    [self.placeholder drawAtPoint:placeholderPoint withAttributes:attributes];
//    // 画到一个范围
////    self.placeholder drawInRect:<#(CGRect)#> withAttributes:<#(nullable NSDictionary<NSString *,id> *)#>
//}

@end
