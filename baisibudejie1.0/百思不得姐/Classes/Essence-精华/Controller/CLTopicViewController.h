//
//  CLTopicViewController.h
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/6.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTopic.h"

@interface CLTopicViewController : UITableViewController

/** 帖子的类型 */
// @property (nonatomic, assign) XMGTopicType type;

- (CLTopicType)type;

// 这个属性会生成一个type的get方法 和 _type成员变量
// @property (nonatomic, assign, readonly) XMGTopicType type;
@end

