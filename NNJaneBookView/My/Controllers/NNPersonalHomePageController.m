//
//  NNPersonalHomePageController.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNPersonalHomePageController.h"
#import "NNPersonalHomePageHeaderImageView.h"
#import "NNPersonalHomePageHeaderView.h"
#import "NNContentScrollView.h"
#import "NNContentTableView.h"
#import "NNPersonalHomePageTitleView.h"

@interface NNPersonalHomePageController ()<UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) NNPersonalHomePageHeaderImageView *headerImageView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) NNContentScrollView *scrollView;
@property (nonatomic, weak) NNContentTableView *dynamicTableView;
@property (nonatomic, weak) NNContentTableView *articleTableView;
@property (nonatomic, weak) NNContentTableView *moreTableView;
@property (nonatomic, weak) UIView *tableViewHeadView;
@property (nonatomic, weak) NNPersonalHomePageTitleView *titleView;

@end

@implementation NNPersonalHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor                            = [UIColor whiteColor];
    self.edgesForExtendedLayout                          = UIRectEdgeNone;
    [self setupContentView];
    [self setupHeaderImageView];
    [self setupHeaderView];
}

/// 头像
- (void)setupHeaderImageView {
    self.headerImageView          = [[NNPersonalHomePageHeaderImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
    [self.headerImageView reloadSizeWithScrollView:self.dynamicTableView];
     //y = 44-30
    self.headerImageView.frame = CGRectMake(NNScreenWidth/2-30, 14, 60, 60);
    [[UIApplication sharedApplication].keyWindow addSubview:self.headerImageView];

    
    [self.headerImageView handleClickActionWithBlock:^{
        NSLog(@"你点击了头像按钮");
    }];
}

/// 主要内容
- (void)setupContentView {
    NNContentScrollView *scrollView           = [[NNContentScrollView alloc] init];
    scrollView.delaysContentTouches           = NO;
    [self.view addSubview:scrollView];
    self.scrollView                           = scrollView;
    scrollView.pagingEnabled                  = YES;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate                       = self;
    scrollView.contentSize                    = CGSizeMake(NNScreenWidth * 3, 0);
    UIView *headView                          = [[UIView alloc] init];
    headView.frame                            = CGRectMake(0, 0, 0, NNHeadViewHeight + NNTitleHeight);
    self.tableViewHeadView = headView;
    
    NNContentTableView *dynamicTableView = [[NNContentTableView alloc] init];
    dynamicTableView.delegate            = self;
    dynamicTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.dynamicTableView                = dynamicTableView;
    dynamicTableView.tableHeaderView     = headView;
    [scrollView addSubview:dynamicTableView];
    [dynamicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(NNScreenWidth);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    NNContentTableView *articleTableView = [[NNContentTableView alloc] init];
    articleTableView.delegate            = self;
    articleTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.articleTableView                = articleTableView;
    articleTableView.tableHeaderView     = headView;
    [scrollView addSubview:articleTableView];
    [articleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(NNScreenWidth);
        make.width.equalTo(dynamicTableView);
        make.top.bottom.equalTo(dynamicTableView);
    }];
    
    NNContentTableView *moreTableView = [[NNContentTableView alloc] init];
    moreTableView.delegate            = self;
    moreTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.moreTableView                = moreTableView;
    moreTableView.tableHeaderView     = headView;
    [scrollView addSubview:moreTableView];
    [moreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(NNScreenWidth * 2);
        make.width.equalTo(dynamicTableView);
        make.top.bottom.equalTo(dynamicTableView);
    }];
}

/// tableView 的头部视图
- (void)setupHeaderView {
    UIView *headerView                     = [[NNPersonalHomePageHeaderView alloc] init];
    headerView.frame                       = CGRectMake(0, 0, NNScreenWidth, NNHeadViewHeight + NNTitleHeight);
    [self.view addSubview:headerView];
    self.headerView                        = headerView;
    NNPersonalHomePageTitleView *titleView = [[NNPersonalHomePageTitleView alloc] init];
    [headerView addSubview:titleView];
    self.titleView                         = titleView;
    titleView.backgroundColor              = [UIColor whiteColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(headerView);
        make.bottom.equalTo(headerView.mas_bottom);
        make.height.mas_equalTo(NNTitleHeight);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(headerView.top);
    }];
    
    __weak typeof(self) weakSelf = self;
    titleView.titles             = @[@"动态", @"文章", @"更多"];
    titleView.selectedIndex      = 0;
    titleView.buttonSelected     = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(NNScreenWidth * index, 0) animated:YES];
    };
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX       = scrollView.contentOffset.x;
        NSInteger pageNum            = contentOffsetX / NNScreenWidth + 0.5;
        self.titleView.selectedIndex = pageNum;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView || !scrollView.window) {
        return;
    }
        CGFloat offsetY      = scrollView.contentOffset.y;
        CGFloat originY      = 0;
        CGFloat otherOffsetY = 0;
    if (offsetY <= NNHeadViewHeight) {
        originY              = -offsetY;
        if (offsetY < 0) {
        otherOffsetY         = 0;
        } else {
        otherOffsetY         = offsetY;
        }
    } else {
        originY              = -NNHeadViewHeight;
        otherOffsetY         = NNHeadViewHeight;
    }
    self.headerView.frame = CGRectMake(0, originY, NNScreenWidth, NNHeadViewHeight + NNTitleHeight);
    for ( int i = 0; i < self.titleView.titles.count; i++ ) {
        if (i != self.titleView.selectedIndex) {
            UITableView *contentView = self.scrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < NNHeadViewHeight || offset.y < NNHeadViewHeight) {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offset = offset;
                }
            }
        }
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    NSLog(@"控制器已销毁");
}

@end
