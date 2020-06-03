//
//  ABTableViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABTableViewController.h"
#import "ABAddContactsViewController.h"

@interface ABTableViewController ()

@end

@implementation ABTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
}

- (void)setUsername:(NSString *)username{
    _username = username;
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",username];
}

/**
 注销
 */
-(void)logout{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];

     UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self.navigationController popViewControllerAnimated:YES];
     }];
    
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:confirmAction];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
}
/**
 新增通讯录
 */
-(void)add{
    [self.navigationController pushViewController:[[ABAddContactsViewController alloc]init] animated:YES];
}
@end
