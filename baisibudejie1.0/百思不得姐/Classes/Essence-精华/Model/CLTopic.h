//
//  CLTpoic.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/30.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef enum {
//    CLTopicTypePicture = 10,
//    CLTopicTypeWord = 29,
//    CLTopicTypeVoice = 31,
//    CLTopicTypeVideo = 41,
//}CLTopicType;


typedef NS_ENUM(NSInteger , CLTopicType) {
    /** 全部 */
    CLTopicTypeAll = 1,
    /** 图片 */
    CLTopicTypePicture = 10,
    /** 段子 */
    CLTopicTypeWord = 29,
    /** 音频 */
    CLTopicTypeVoice = 31,
    /** 视频 */
    CLTopicTypeVideo = 41,
};


@class CLComment;

@interface CLTopic : NSObject


/** 用户id */
@property(nonatomic,copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property(nonatomic,strong)CLComment *top_cmt;
/** 中间内容类型 */
@property(nonatomic,assign)CLTopicType type;
/** 图片真实高度 */
@property(nonatomic,assign)CGFloat height;
/** 图片真实宽度 */
@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)BOOL is_gif;
/** 小图 */
@property(nonatomic,strong)NSString *small_image;
/** 大图原图 */
@property(nonatomic,strong)NSString *large_image;
/** 中图 */
@property(nonatomic,strong)NSString *middle_image;


/** video播放时间 */
@property(nonatomic,assign)NSInteger videotime;
/** voice播放时间 */
@property(nonatomic,assign)NSInteger voicetime;
/** 播放次数 */
@property(nonatomic,assign)NSInteger playcount;

@property(nonatomic,strong)NSString *videouri;

@property(nonatomic,strong)NSString *voiceuri;

/** 声音是否在播放 */
@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;

/*****  额外添加的属性 ******/
/** 判断是否为大图的标识 */

@property(nonatomic,assign)BOOL isBigPicture;
/** cell的高度计算 */
@property(nonatomic,assign)CGFloat cellHeight;
/** 中间控件的frame */
@property(nonatomic,assign)CGRect contentF;

@end
