//
//  CLTopicVideoView.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/5.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopicVideoView.h"
#import "CLTopic.h"
#import <UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CLTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end

@implementation CLTopicVideoView


-(void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ,会自动将控件根据父控件进行伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (IBAction)playButtonClick:(UIButton *)sender {

    // 跳转控制器进行播放
    NSURL *videoPathURL=[[NSURL alloc] initWithString:self.topic.videouri];
    
    MPMoviePlayerViewController *vc =[[MPMoviePlayerViewController alloc]initWithContentURL:videoPathURL];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)setTopic:(CLTopic *)topic
{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute , second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
}

@end
