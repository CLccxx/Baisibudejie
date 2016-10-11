//
//  CLRecommendTagCell.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/6.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLRecommendTagCell.h"
#import <UIImageView+WebCache.h>
#import "CLRecommendTag.h"
@interface CLRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation CLRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setRecommendTag:(CLRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 设置圆形头像，占位图片在方法内部设置
    [self.imageListView setCircleHeader:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人关注",recommendTag.sub_number / 10000.0];
    }else{
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人关注",recommendTag.sub_number];
    }
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
