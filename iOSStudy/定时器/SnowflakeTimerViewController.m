//
//  SnowflakeTimerViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SnowflakeTimerViewController.h"
#import "SnowflakeView.h"
#import "Masonry.h"

@interface SnowflakeTimerViewController ()

@end

@implementation SnowflakeTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"雪花效果";
    
    SnowflakeView *view = [[SnowflakeView alloc] init];
    view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:view];
    //view的约束
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
}

@end
