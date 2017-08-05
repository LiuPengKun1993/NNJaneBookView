//
//  NNContentScrollView.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNContentScrollView.h"

@implementation NNContentScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setOffset:(CGPoint)offset {
    _offset = offset;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view       = [super hitTest:point withEvent:event];
    BOOL hitHead       = point.y < (NNHeadViewHeight - self.offset.y);
    if (hitHead || !view) {
    self.scrollEnabled = NO;
        if (!view) {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x) {
                    view = subView;
                }
            }
        }
        return view;
    } else {
    self.scrollEnabled = YES;
        return view;
    }
}

@end
