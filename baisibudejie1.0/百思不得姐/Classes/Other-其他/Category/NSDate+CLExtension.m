//
//  NSDate+CLExtension.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/3.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "NSDate+CLExtension.h"

@implementation NSDate (CLExtension)

-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar calendar];
    
    NSInteger creatYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return creatYear == nowYear;
}

//-(BOOL)isThisYear
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy";
//    
//    NSString *creatYear = [fmt stringFromDate:self];
//    NSString *nowYear = [fmt stringFromDate:[NSDate date]];
//    return [creatYear isEqualToString:nowYear];
//}

-(BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyyMMdd";
    NSString *creatStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [creatStr isEqualToString:nowStr];
    
}
//-(BOOL)isToday
//{
//    NSCalendar *calendar = [NSCalendar calendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *cmp =  [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
//    return cmp.year == 0 && cmp.month == 0 && cmp.day == 0;
//}
-(BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *creatStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *creatDate = [fmt dateFromString:creatStr];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmp = [calendar components:unit fromDate:creatDate toDate:nowDate options:0];
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
}
-(BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *creatStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *creatDate = [fmt dateFromString:creatStr];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmp = [calendar components:unit fromDate:creatDate toDate:nowDate options:0];
    return cmp.year == 0 && cmp.month == 0 && cmp.day == -1;
}

@end
