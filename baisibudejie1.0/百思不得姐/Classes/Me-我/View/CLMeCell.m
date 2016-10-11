//
//  CLMeCell.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/25.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMeCell.h"

@implementation CLMeCell

// 加载cell通过这个方法，因为需要重用
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 可以在这个方法中对cell进行一些统一的设置
        self.textLabel.textColor = [UIColor darkGrayColor];
        // 设置cell的背景颜色
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        // 设置右边箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 也可以设置为自定义的图片
//        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imageName"]];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 如果cell的图片比较大，可以再这里进行布局修改
//    self.imageView.cl_y = CLMargin;
    
}

@end
