//
//  CLTopicCell.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/2.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopicCell.h"
#import <UIImageView+WebCache.h>
#import "CLTopic.h"
#import "CLComment.h"
#import "CLUser.h"

#import "CLTopicVideoView.h"
#import "CLTopicVoiceView.h"
#import "CLTopicPictureView.h"

@interface CLTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 热门评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 中间控件 */
/** 视频控件 */
@property(nonatomic,weak)CLTopicVideoView *videoView;
/** 音频控件 */
@property(nonatomic,weak)CLTopicVoiceView *voiceView;
/** 图片控件 */
@property(nonatomic,weak)CLTopicPictureView *pictureView;

@end

@implementation CLTopicCell

#pragma mark -中间控件懒加载
-(CLTopicVideoView *)videoView
{
    if (_videoView == nil) {
        CLTopicVideoView *videoView = [CLTopicVideoView viewFromNib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
-(CLTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        CLTopicVoiceView *voiceView = [CLTopicVoiceView viewFromNib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
-(CLTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        CLTopicPictureView *pictureView = [CLTopicPictureView viewFromNib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}


- (IBAction)moreClick {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"弹出消息标题" message:@"弹出消息内容" preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLLog(@"点击了【收藏】");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        CLLog(@"点击了【举报】");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CLLog(@"点击了【取消】");
    }]];
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

//设置背景图片
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(CLTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView setCircleHeader:topic.profile_image];
    

    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;

    [self setUpButton:self.dingButton Number:topic.ding Placeholder:@"顶"];
    [self setUpButton:self.caiButton Number:topic.cai Placeholder:@"踩"];
    [self setUpButton:self.repostButton Number:topic.repost Placeholder:@"分享"];
    [self setUpButton:self.commentButton Number:topic.comment Placeholder:@"评论"];
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        NSString *userName = topic.top_cmt.user.username;
        NSString *contentText = topic.top_cmt.content;

        // 如果有音频时间，说明是语音评论，说明一下，并且高度计算其中，防止用户名过长，热门评论高度计算不对
        if (topic.top_cmt.voiceuri.length) {
            contentText = @"[语音消息]";
        }
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,contentText];
    }else{
        self.topCmtView.hidden = YES;
        
    }
    
#pragma mark - 中间数据类型
    if (topic.type == CLTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (topic.type == CLTopicTypeVoice){
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        self.pictureView.hidden = YES;
    }else if (topic.type == CLTopicTypeWord){
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (topic.type == CLTopicTypePicture){
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
    }
}

-(void)setUpButton:(UIButton *)button Number:(NSInteger)number Placeholder:(NSString *)placeholder
{
    NSString *strNum = [NSString string];
    if (number >= 10000) {
        strNum = [NSString stringWithFormat:@"%.1f万",number / 10000.0];
    }else if (number == 0){
        strNum = placeholder;
    }else{
        strNum = [NSString stringWithFormat:@"%zd",number];
    }
    [button setTitle:strNum forState:UIControlStateNormal];
}


/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= CLMargin;
//   frame.origin.y += CLMargin;
    [super setFrame:frame];
}


@end
