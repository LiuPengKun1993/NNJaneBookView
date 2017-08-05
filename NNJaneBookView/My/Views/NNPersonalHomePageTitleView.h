//
//  NNPersonalHomePageTitleView.h
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNPersonalHomePageTitleView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);

@end
