//
//  CLEssenceViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/9/21.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLCommentViewController.h"
#import "CLTopic.h"
#import "CLHTTPSessionManager.h"
#import <MJRefresh.h>
#import "CLRefreshHeader.h"
#import "CLRefreshFooter.h"
#import <MJExtension.h>
#import "CLCommentCell.h"
#import "CLComment.h"
#import "CLTopicCell.h"
#import "CLUser.h"

@interface CLCommentViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@property(nonatomic,strong)CLHTTPSessionManager *manager;

@property(nonatomic,strong)NSArray <CLComment *> * hotestComments;
@property(nonatomic,strong)NSMutableArray <CLComment *> * latestComments;

@property(nonatomic,strong)CLComment *saveTopCom;
@end

@implementation CLCommentViewController

static NSString * const CommentTableViewID = @"commentTableView";


#pragma mark - 懒加载

-(CLHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [CLHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    [self setupTable];
    [self setupTableHeard];
    [self setupRefresh];
    
}

- (void)setupBase
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)setupTable
{
    // 注册cell
    [self.commentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CLCommentCell class]) bundle:nil] forCellReuseIdentifier:CommentTableViewID];
    
    // 关闭cell之间的线
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.backgroundColor = CLCommonColor(206);
    
    // 设置cell的高度
    // 设置cell行高自动计算 自动计算尺寸
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
    // 需要先给一个大约的估算高度
    self.commentTableView.estimatedRowHeight = 44;
    
 
}

-(void)setupTableHeard
{
    // 如果有最热评论，则设为空
    // 当控制器销毁的时候，需要将值重新设置回来，并且将cellheight设置为0 让其在重新计算一次。所以先将他保存起来
    self.saveTopCom = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    
    // 从xib加载cell
    CLTopicCell *cell = [CLTopicCell viewFromNib];
    cell.topic = self.topic;
    cell.cl_height = self.topic.cellHeight + 20;
//    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
//    
//    
//    // 创建heardView
//    UIView *heardView =  [[UIView alloc]init];
//    [heardView addSubview:cell];
//    
//    heardView.cl_height = self.topic.cellHeight;
//    heardView.backgroundColor = CLCommonColor(206);
    // 设置heardView
    self.commentTableView.tableHeaderView = cell;
    
}

-(void)setupRefresh
{
    self.commentTableView.mj_header = [CLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [CLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    // /** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO） */
    self.commentTableView.mj_footer.automaticallyHidden = YES;
    
}

-(void)loadNewComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // @"1";
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        CLWriteToPlist(responseObject, @"comment.plist");
        
        // -[__NSArray0 objectForKeyedSubscript:]: unrecognized selector sent to instance 0x7fb738c01870
        // 错误地将NSArray当做NSDictionary来使用了
        

        // 如果没有评论的话 服务器返回的是一个数组
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.commentTableView.mj_header endRefreshing];
            return ;
        }
        
        weakSelf.hotestComments  = [CLComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        weakSelf.latestComments = [CLComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.commentTableView reloadData];
        
        // 结束刷新
        [weakSelf.commentTableView.mj_header endRefreshing];
        
        int total = [responseObject[@"total"]intValue];
        if (weakSelf.latestComments.count == total) {// 说明加载完全了，隐藏上拉刷新
            // 提示用户:没有更多数据
            // [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.commentTableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CLLog(@"%@",error);
        [weakSelf.commentTableView.mj_header endRefreshing];
        
    }];
    
}

-(void)loadMoreComments
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof (self) weakSelf = self;
    
    [self.manager GET:CLCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
//        if (![responseObject isKindOfClass:[NSDictionary class]]) {
//            [weakSelf.commentTableView.mj_footer endRefreshing];
//            return ;
//        }
        
        NSArray *moreCommon = [CLComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.latestComments addObjectsFromArray:moreCommon];
        
        [weakSelf.commentTableView reloadData];
        

        int total = [responseObject[@"total"]intValue];
        if (weakSelf.latestComments.count == total) {// 说明加载完全了，隐藏上拉刷新
            // 提示用户:没有更多数据
            // [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.commentTableView.mj_footer.hidden = YES;
        }else{
            
            // 结束刷新
            [weakSelf.commentTableView.mj_footer endRefreshing];
        }

//        //结束刷新
//        [self.commentTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CLLog(@"%@",error);
        // 结束刷新
        [self.commentTableView.mj_footer endRefreshing];
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//     控制器销毁的时候 将值重新设置回去，并将cellHeight设置为0，让其重新计算
    self.topic.top_cmt = self.saveTopCom;
    self.topic.cellHeight = 0;
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    if (弹出) {
//        self.bottomMargin.constant = 键盘高度;
//    } else {
//        self.bottomMargin.constant = 0;
//    }
    
    // 修改约束  屏幕的高度 - 键盘的y值
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    // 获取执行动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 更新约束
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有最热评论 则表示肯定有最新评论
    if (self.hotestComments.count) return 2;
    // 能来到这里表示没有最热评论，如有有最新评论则返回1
    if (self.latestComments.count) return 1;
    // 能到这一行表示什么都没有
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        if (self.hotestComments.count) {
//            return self.hotestComments.count;
//        }else{
//            return self.latestComments.count;
//        }
//    }
//    return self.latestComments.count;

    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    return self.latestComments.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewID];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    }else{
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 30;
}

// 只能返回字体，如果想要更多的设置 可以返回UIView
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0 && self.hotestComments.count) {
//        return @"最热评论";
//    }
//    return @"最新评论";
//}

#pragma mark - <UITableViewDelegate>

// 如果使用label这里没有办法是label左边有间距
// 可以先添加一个view，然后在view上面添加label
// 我们这里使用button，更加方便一点
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = self.commentTableView.backgroundColor;
    
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, CLMargin, 0, 0);
    
    
    if (section == 0 && self.hotestComments.count) {
        [button setTitle:@"最热评论" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"最新评论" forState:UIControlStateNormal];
    }
    return button;
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end