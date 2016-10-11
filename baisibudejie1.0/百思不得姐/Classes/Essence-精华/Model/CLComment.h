//
//  CLComment.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/4.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLUser;
@interface CLComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 内容 */
@property(nonatomic,strong)NSString *content;
/** 用户(发表评论的人) */
@property(nonatomic,strong)CLUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

@end
