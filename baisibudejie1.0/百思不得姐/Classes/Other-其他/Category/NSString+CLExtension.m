//
//  NSString+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/29.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "NSString+CLExtension.h"

@implementation NSString (CLExtension)



//-(unsigned long long)fileSize
//{
//    unsigned long long size = 0;
//
//    NSFileManager *manager = [NSFileManager defaultManager];
//    // 获取文件属性字典
//    NSDictionary *attribute = [manager attributesOfItemAtPath:self error:nil];
//
//    if ([attribute.fileType isEqualToString:NSFileTypeDirectory]) {
//
//        NSArray *subpaths = [manager subpathsAtPath:self];
//        for (NSString *subpath in subpaths) {
//            // 拼接成完整路径
//            NSString *fullParh = [self stringByAppendingPathComponent:subpath];
//            NSDictionary *attr = [manager attributesOfItemAtPath:fullParh error:nil];
//            size += attr.fileSize;
//        }
//    }else{
//        size = attribute.fileSize;
//    }
//    return size;
//}


-(unsigned long long)fileSize
{
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL directory = NO;
    BOOL exists = [manager fileExistsAtPath:self isDirectory:&directory];
    // 如果地址为空
    if (!exists) return size;
    // 如果是文件夹
    if (directory) {
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *path in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:path];
            NSDictionary *attr = [manager attributesOfItemAtPath:fullPath error:nil];
            size += attr.fileSize;
        }
    }else{
        size = [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

@end
