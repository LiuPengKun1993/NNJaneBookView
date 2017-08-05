//
//  NNMyController.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/4.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNMyController.h"
#import "NNPersonalHomePageController.h"
#import "NNsettingViewController.h"

@interface NNMyController ()

@end

@implementation NNMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
}

/// 设置导航栏右边的按钮
- (void)setupNav {
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)settingBtnClick {
    NNsettingViewController *settingVC = [[NNsettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)setupUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    CGSize size      = CGSizeMake(100, 40);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClicked {
    NNPersonalHomePageController *personHomePageVC = [[NNPersonalHomePageController alloc] init];
    personHomePageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personHomePageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
