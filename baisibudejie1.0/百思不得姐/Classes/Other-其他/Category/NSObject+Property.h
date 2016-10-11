//
//  NSObject+Property.h
//  05-Runtime(字典转模型KVC实现)
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2013年 yyy. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;


@end
