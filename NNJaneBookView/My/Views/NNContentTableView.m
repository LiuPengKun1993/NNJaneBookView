//
//  NNContentTableView.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNContentTableView.h"

@interface NNContentTableView ()<UITableViewDataSource>

@end
static NSString *NNContentTableViewCellID = @"NNContentTableView";
@implementation NNContentTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
    }
    return self;
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    if (self.window) {
        [super setContentOffset:contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NNContentTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NNContentTableViewCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试:%ld", indexPath.row];
    return cell;
}

@end
