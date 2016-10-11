//
//  CLTopicPictureView.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/5.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "CLTopic.h"
#import <DALabeledCircularProgressView.h>
#import "CLSeeBigViewController.h"

@interface CLTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation CLTopicPictureView


-(void)awakeFromNib
{
     // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ,会自动将控件根据父控件进行伸缩
    // 取消其伸缩效果
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}
- (IBAction)seeBigButtonClick {
    
    [self seeBig];
}

- (void)seeBig
{
    CLSeeBigViewController *seeBig = [[CLSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

-(void)setTopic:(CLTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // receivedSize ：已经下载的进度
        // expectedSize ：完整大小
        CGFloat progress =1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    
    //进行网络判断等
    
    // 判断是否是gif动态图
     // 先将url全部转化为小写，然后判断后缀
    //    if ([topic.large_image.lowercaseString hasSuffix:@"gif"]) {
//           }
    // 拿到url的后缀，然后转化为小写，然后与gif比较
    //    if ([topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]){
//           }
    if (topic.is_gif) {
        self.gifImageView.hidden = NO;
    }else{
        self.gifImageView.hidden = YES;
    }
    // 判断是否为大图
    if(topic.isBigPicture){
        self.seeBigButton.hidden = NO;
        // 设置imageView的裁剪，以显示顶部为准
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigButton.hidden = YES;
        // 如果不是需要将大图的设置还原，防止cell重用设置
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
  
    
    
//    使用AFN进行网络判断
//
//    网络判断
//    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN) { // 手机自带网络
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
//    } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) { // WIFI
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
//    } else { // 网络有问题, 清空当前显示的图片
//        self.imageView.image = nil;
//    }
    
}

@end
