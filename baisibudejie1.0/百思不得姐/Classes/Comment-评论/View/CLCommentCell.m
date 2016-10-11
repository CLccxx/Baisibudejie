//
//  CLCommentCell.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/7.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLCommentCell.h"
#import "CLComment.h"
#import "CLUser.h"

@interface CLCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation CLCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setComment:(CLComment *)comment
{
//    _comment = comment;
//    
//    // 设置cell内容
//    // 设置头像
//    [self.profileImageView setCircleHeader:comment.user.profile_image];
//    // 设置性别图片
//    NSString *sexImageName = [comment.user.sex isEqualToString:CLUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
//    self.sexView.image = [UIImage imageNamed:sexImageName];
//    // 设置用户姓名
//    self.usernameLabel.text = comment.user.username;
//    // 设置点赞数量
//    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
//    if (comment.voiceuri.length) {
//        self.voiceButton.hidden = NO;
//        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
//    } else {
//        self.voiceButton.hidden = YES;
//    }
    
    
    _comment = comment;
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    [self.profileImageView setHeader:comment.user.profile_image];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:CLUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image =  [UIImage imageNamed:sexImageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }

}

@end
