//
//  NNPersonalHomePageHeaderImageView.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNPersonalHomePageHeaderImageView.h"

static NSString *const NNContentOffset = @"contentOffset";

@interface NNPersonalHomePageHeaderImageView()

@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, copy) NNClickHeaderBlock clickHeaderBlock;

@end

@implementation NNPersonalHomePageHeaderImageView

#pragma mark - 初始化
- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        [self setupUI];
        self.image = image;
    }
    return self;
}

- (void)reloadSizeWithScrollView:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:NNContentOffset options:NSKeyValueObservingOptionNew context:nil];
}

- (void)handleClickActionWithBlock:(NNClickHeaderBlock)block {
    self.clickHeaderBlock = block;
    self.userInteractionEnabled = YES;
    
    [self.headerButton addTarget:self action:@selector(tapHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.headerButton setImage:image forState:UIControlStateNormal];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.headerButton.layer.borderColor = borderColor.CGColor;
}

- (void)setupUI {
    CGFloat kWidth                   = 60;
    self.frame                       = CGRectMake(0, 0, kWidth, kWidth);
    self.headerButton                = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame              = CGRectMake(0, 0, kWidth, kWidth);
    _headerButton.center             = CGPointMake(kWidth / 2, kWidth / 2);
    _headerButton.backgroundColor    = [UIColor clearColor];
    _headerButton.layer.borderWidth  = 0.5f;
    _headerButton.layer.cornerRadius = kWidth / 2;
    _headerButton.layer.borderColor  = [UIColor grayColor].CGColor;
    _headerButton.clipsToBounds      = YES;
    [self addSubview:_headerButton];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NNContentOffset] && object == self.scrollView) {

        CGFloat offsetY             = self.scrollView.contentOffset.y;
        CGFloat scale               = 1.0;
        if (offsetY < 0) { // 放大
        scale                       = MIN(1.2, 1 - offsetY / 300);
        } else if (offsetY > 0) { // 缩小
        scale                       = MAX(0.5, 1 - offsetY / 300);
        }
        self.headerButton.transform = CGAffineTransformMakeScale(scale, scale);

        CGRect frame                = self.headerButton.frame;
        frame.origin.y              = 15;
        self.headerButton.frame     = frame;
    }
}

- (void)tapHeaderAction:(UITapGestureRecognizer *)sender {
    if (_clickHeaderBlock) {
        _clickHeaderBlock();
    }
}

- (void)dealloc {
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:NNContentOffset context:nil];
    }
}

@end
