//
//  NNPersonalHomePageHeaderImageView.h
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NNClickHeaderBlock) ();

@interface NNPersonalHomePageHeaderImageView : UIView

/// 头像图片
@property (nonatomic, strong) UIImage *image;
/// 边框颜色
@property (nonatomic, strong) UIColor *borderColor;
/// 初始化
- (instancetype)initWithImage:(UIImage *)image;
/// 滚动视图
- (void)reloadSizeWithScrollView:(UIScrollView *)scrollView;
/// 点击头像回调
- (void)handleClickActionWithBlock:(NNClickHeaderBlock)block;

@end
