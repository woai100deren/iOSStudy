//
//  BaseConstactsViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "BaseConstactsViewController.h"
#import "BaseContactsAddViewController.h"

@interface BaseConstactsViewController ()

@end

@implementation BaseConstactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
}

-(void)goBack{
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)add{
    // 设置B的hidesBottomBarWhenPushe
    BaseContactsAddViewController *BVC = [[BaseContactsAddViewController alloc] init];
    BVC.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:BVC animated:YES];
}
@end
