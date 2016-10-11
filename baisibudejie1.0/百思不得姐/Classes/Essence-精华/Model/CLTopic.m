//
//  CLTpoic.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/30.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopic.h"
#import <MJExtension.h>
#import "CLComment.h"
#import "CLUser.h"


@implementation CLTopic

static NSCalendar *calendar_ ;
static NSDateFormatter *fmt_;


//第一次使用CLTopic类时调用一次
+(void)initialize
{
    calendar_ = [NSCalendar calendar];
    fmt_ = [[NSDateFormatter alloc]init];
}

// 日期的处理
-(NSString *)created_at
{
    fmt_.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *createdAtDate =  [fmt_ dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) {// 是今年
        
        // 判断是否是今天和昨天的方法是iOS8 才有的，如果需要适配iOS7 我们可以自己在分类中实现判断是否为今天和昨天
        
        [calendar_ isDateInToday:createdAtDate];
        [calendar_ isDateInYesterday:createdAtDate];
        if (createdAtDate.isToday) {// 是今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) {// 时间间隔大于一个小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (createdAtDate.isYesterday){ //是昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
            
        }else{
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    }else{ // 不是今年，直接返回直接即可
        return _created_at;
    }
    return nil;
}
/**
 // _created_at == @"2015-11-20 09:10:05"
 // _created_at -> @"刚刚" \ @"10分钟前" \ @"5小时前" \ @"昨天 09:10:05" \ @"11-20 09:10:05" \ @"2015-11-20 09:10:05"
 
 今年
 今天
 时间间隔 >= 1小时 - @"5小时前"
 1小时 > 时间间隔 >= 1分钟 - @"10分钟前"
 1分钟 > 分钟 - @"刚刚"
 昨天 - @"昨天 09:10:05"
 其他 - @"11-20 09:10:05"
 
 
 非今年 - @"2015-11-20 09:10:05"
 
 */

// cell高度的计算
-(CGFloat)cellHeight
{
    // iOS8 开始cell不会缓存 cell的高度，每次显示cell都会来到这里计算一下，造成不必要计算
    // 如果计算过一次高度就不要在计算了,直接返回模型的高度即可。
    // 或者
//    if (_cellHeight)return _cellHeight;
    
    if (_cellHeight == 0) {
        
        // 1.头像高度
        _cellHeight = 56;
        // 2.文字高度 需要提供文字的大小和显示的宽度
        CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * CLMargin;
        // 需要给一个较大值的高度，如果计算出来的高度小于这个高度就会使用计算出来的高度
        CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    //    CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize];
        
        CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
        
        _cellHeight += textSize.height + CLMargin;
        
        // 3. 图片的高度，需要判断有没有图片显示
        if (self.type != CLTopicTypeWord) {
            // 图片高度需要根据能显示的最大宽度等比进行计算 中间内容高度 = 中间内容宽度 * 图片实际高度 / 图片实际宽度
            CGFloat Height = textMaxW * self.height / self.width;
            
            // 判断是否是大图，如果是大图则高度设置为250
            if (Height >= [UIScreen mainScreen].bounds.size.height) {
                Height = 250;
                self.isBigPicture = YES;
            }
            self.contentF = CGRectMake(CLMargin, _cellHeight, textMaxW, Height);
            
            _cellHeight += Height + CLMargin;
            
        }
        // 4. 最热评论高度计算
        if (self.top_cmt) {
            // 4.1 最热评论标题高度 18
            _cellHeight += 18;
            // 4.1 最热评论内容高度
            
            // 如果有音频时间，说明是语音评论，说明一下，并且高度计算其中，防止用户名过长，热门评论高度计算不对
            NSString *content = self.top_cmt.content;
            if (self.top_cmt.voiceuri.length) {
                content = @"[语音评论]";
            }
            
            NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,content];
            
    //        CGSize topCmtContentSize = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
            
            CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            _cellHeight += topCmtContentSize.height + CLMargin;
        }
        // 5. 底部工具条 + cell之间的间距10
        _cellHeight += 35 + CLMargin;
    }
    return _cellHeight;
}



@end
