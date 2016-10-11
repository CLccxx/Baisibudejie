//
//  CLClearCacheCell.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/29.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLClearCacheCell.h"
#import <SDImageCache.h>
#import "NSString+CLExtension.h"
#import <SVProgressHUD.h>

#define CLCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"]

@implementation CLClearCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"%@",CLCustomCacheFile);
        self.textLabel.text = @"清除缓存(正在计算文件大小...)";
        // 等设置完文字之后在禁止点击，如果直接禁止点击 字体颜色会被渲染成灰色
        self.userInteractionEnabled = NO;
        
        UIActivityIndicatorView *indicatorView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        self.accessoryView = indicatorView;
        
        
        __weak typeof(self) weakSelf = self;
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [NSThread sleepForTimeInterval:2];
            
//            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//            
//            NSString *fullPath = [cachePath stringByAppendingPathComponent:@"custom"];
            
            // 添加成一个宏
//            NSString *fullPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"];
    
            unsigned long long size = CLCustomCacheFile.fileSize + [SDImageCache sharedImageCache].getSize;
            
            // 判断cell是否已经被销毁,如果销毁了就直接返回
            if (weakSelf == nil) {
                return ;
            }
            NSString *sizeText = nil;
            //pow(10, 9) = 10的9次方
            
            if (size >= pow(10, 9)) {
                sizeText = [NSString stringWithFormat:@"%.1fGB",size / 1000.0 / 1000.0 / 1000.0];
            }else if (size >= pow(10, 6)){
                sizeText = [NSString stringWithFormat:@"%.1fMB",size / 1000.0 / 1000.0];
            }else if (size >= pow(10, 3)){
                sizeText = [NSString stringWithFormat:@"%.1fKB",size / 1000.0];
            }else{
                sizeText = [NSString stringWithFormat:@"%zdB",size];
            }
            
            NSString *text = [NSString stringWithFormat:@"清除缓存（%@）",sizeText];
            dispatch_async(dispatch_get_main_queue(), ^{
    
                weakSelf.textLabel.text = text;
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                weakSelf.userInteractionEnabled = YES;
                // 等计算完缓存大小之后在添加手势，保证正在计算过程中cell 点击无效
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(celltap:)]];
                
            });
        });
    }
    return self;
}

-(void)celltap:(UITapGestureRecognizer *)tap
{
    [SVProgressHUD showWithStatus:@"正在清除缓存"];

    // 清除所有图片文件 clearn 只清除时间超过一周的文件
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 清除之后要做的事儿
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:CLCustomCacheFile error:nil];
            //            withIntermediateDirectories:YES ,表示中间文件如果没有会自动创建，NO 也不会自动创建中间文件，如果发现没有文件则不会创建
            [manager createDirectoryAtPath:CLCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];

    #warning 睡两秒
            // 增加一个延迟。
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
               // 隐藏指示器
                [SVProgressHUD dismiss];
                self.textLabel.text = @"清除缓存（0B）";
            });
        });
    }];
}

// 每当cell 重新显示在桌面上 ，都会调用laoutsubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)self.accessoryView;
    [indicator startAnimating];
    
}
@end
