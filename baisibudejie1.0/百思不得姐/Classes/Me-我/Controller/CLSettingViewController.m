//
//  CLSettingViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/22.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLSettingViewController.h"
#import "NSString+CLExtension.h"
#import <SDImageCache.h>
#import "CLClearCacheCell.h"
#import "CLSettingCell.h"

@interface CLSettingViewController ()
@end

@implementation CLSettingViewController

static NSString * const CLClearCacheCellId = @"CLClearCacheCell";
static NSString * const CLSettingCellId = @"CLSettingCellId";

-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getCacheSize];
//    [self getCacheSize2];
    
//    CLLog(@"%zd",@"/Users/yangboxing/Desktop/简历".fileSize);
    
    // 注册cell
    [self.tableView registerClass:[CLClearCacheCell class] forCellReuseIdentifier:CLClearCacheCellId];

    [self.tableView registerClass:[CLSettingCell class] forCellReuseIdentifier:CLSettingCellId];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 按照不同的标识 重用不同的cell
    // 取出cell
    if (indexPath.row == 0) {
        CLClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:CLClearCacheCellId];
        return cell;
    }else{
        CLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CLSettingCellId];
        cell.textLabel.text = @"haha";
        return cell;
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CLLogfunc;
//}


// 计算文件大小的两种方法
// 使用遍历器
-(void)getCacheSize2
{
    //  mac中换算MB 除以1000,并不是以1024为单位
    // 总大小
    unsigned long long size = 0;
    // 获取缓存文件路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 拼接全文件路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"default"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 这个只获取文件夹下面的一级文件 返回路径
    //    [manager contentsOfDirectoryAtPath:filePath error:nil];
    // 会将文件夹下面的所有子文件内部也遍历完毕 返回路径
    //    [manager subpathsAtPath:filePath];
    
    // 遍历器，迭代器
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:filePath];
    for (NSString *subpath in enumerator) {
        // 拼接成完整路径
        NSString *fullParh = [filePath stringByAppendingPathComponent:subpath];
        // 获取文件属性字典
        NSDictionary *attribute = [manager attributesOfItemAtPath:fullParh error:nil];
        
        size += attribute.fileSize;
    }
    NSLog(@"%zd",size);
}

-(void)getCacheSize
{
    //  mac中换算MB 除以1000,并不是以1024为单位
    // 总大小
    unsigned long long size = 0;
    // 获取缓存文件路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 拼接全文件路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"default"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 这个只获取文件夹下面的一级文件 返回路径
    //    [manager contentsOfDirectoryAtPath:filePath error:nil];
    // 会将文件夹下面的所有子文件内部也遍历完毕 返回路径
    //    [manager subpathsAtPath:filePath];
    
    NSArray *subpaths = [manager subpathsAtPath:filePath];
    for (NSString *subpath in subpaths) {
        // 拼接成完整路径
        NSString *fullParh = [filePath stringByAppendingPathComponent:subpath];
        // 获取文件属性字典
        NSDictionary *attribute = [manager attributesOfItemAtPath:fullParh error:nil];
        //        // 累加文件大小
        //        size += [attribute[NSFileSize] unsignedIntegerValue];
        // fileSize方法返回的就是 NSFileSize 对应的key
        size += attribute.fileSize;
    }
    NSLog(@"%zd",size);
    NSLog(@"%@",NSHomeDirectory());
    
    
    // SD也可以获得文件大小，只不过只能过去图片的大小
    //    NSInteger sd_size = [SDImageCache sharedImageCache].getSize;
    //    NSLog(@"%zd",sd_size);
    // 获取图片文件的数量
    NSInteger count = [SDImageCache sharedImageCache].getDiskCount;
    NSLog(@"%zd",count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
