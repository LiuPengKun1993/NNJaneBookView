//
//  NNPersonalHomePageHeaderView.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNPersonalHomePageHeaderView.h"
@interface NNPersonalHomePageHeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *editInfoButton;
@end
@implementation NNPersonalHomePageHeaderView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UIButton class]]) {
        return view;
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.nameLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.editInfoButton];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-15);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(300);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.mas_equalTo(self.infoLabel.mas_top).offset(-10);
        make.centerX.mas_equalTo(self.infoLabel);
    }];
    [self.editInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.infoLabel);
        make.width.mas_equalTo(100);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _nameLabel.text            = @"n以梦为马";
        _nameLabel.textAlignment   = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor       = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        _infoLabel.text            = @"北京\n\n有三秋桂子，十里荷花\n\n写了100字，获得100个喜欢";
        _infoLabel.textAlignment   = NSTextAlignmentCenter;
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor       = [UIColor grayColor];
        _infoLabel.numberOfLines   = 0;
        _infoLabel.font            = [UIFont systemFontOfSize:11];
    }
    return _infoLabel;
}

- (UIButton *)editInfoButton {
    if (!_editInfoButton) {
        _editInfoButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editInfoButton setTitle:@"编辑个人资料" forState:UIControlStateNormal];
        _editInfoButton.titleLabel.font    = [UIFont boldSystemFontOfSize:11];
        [_editInfoButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _editInfoButton.layer.borderColor  = [UIColor redColor].CGColor;
        _editInfoButton.layer.cornerRadius = 2;
        _editInfoButton.layer.borderWidth  = 0.5f;
        [_editInfoButton addTarget:self action:@selector(clickedEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editInfoButton;
}

- (void)clickedEditAction:(UIButton *)sender {
    NSLog(@"你点击了编辑资料按钮");
}

@end
