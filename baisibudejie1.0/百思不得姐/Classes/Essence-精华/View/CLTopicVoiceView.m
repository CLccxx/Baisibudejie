//
//  CLTopicVoiceView.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/5.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopicVoiceView.h"
#import "CLTopic.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import "CLWebViewController.h"

static AVPlayer *player_;
static UIButton *lastPlayBtn_;
static CLTopic *lastTopic_;

@interface CLTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation CLTopicVoiceView

-(void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ,会自动将控件根据父控件进行伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(CLTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    
    //按钮是否在播放?  播放状态和为播放状态设置不一样的图片
    [self.playBtn setImage:[UIImage imageNamed:topic.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        //保存
        player_ = [AVPlayer playerWithPlayerItem:playerItem];
        
    });
    
}


- (IBAction)voicePlayerBegin:(UIButton *)playButton {
    
    //修改按钮的状态
    playButton.selected = !playButton.isSelected;
    lastPlayBtn_.selected = !lastPlayBtn_.isSelected;
    
    if (lastTopic_ != self.topic) {
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        //取代播放
        [player_ replaceCurrentItemWithPlayerItem:playerItem];
        [player_ play];
        //上一个没有播放
        lastTopic_.voicePlaying = NO;
        //当前的正在播放
        self.topic.voicePlaying = YES;
        
        [lastPlayBtn_ setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
        
    }else
    {
        if (lastTopic_.voicePlaying) { // 上一个如果正在播放
            //停止播放
            [player_ pause];
            self.topic.voicePlaying = NO;
            [playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        }else
        {
            [player_ play];
            self.topic.voicePlaying = YES;
            [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
            
        }
    }
    
    lastPlayBtn_ = playButton;
    lastTopic_ = self.topic;

    
}

@end
