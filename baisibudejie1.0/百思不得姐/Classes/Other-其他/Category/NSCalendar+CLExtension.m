//
//  NSCalendar+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/3.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "NSCalendar+CLExtension.h"

@implementation NSCalendar (CLExtension)

+(instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}

@end
