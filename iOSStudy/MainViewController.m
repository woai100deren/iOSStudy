//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"
#import "MasonryViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ScrollViewController.h"
#import "TableViewIndexsController.h"
#import "TableViewCustonCellViewController.h"
#import "TableViewDiffCellViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    //去掉返回文字
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (IBAction)jumpTableView:(id)sender {
    [self jump:[[TableViewController alloc] init]];
}
- (IBAction)jumpMasonry:(id)sender {
    [self jump:[[MasonryViewController alloc] init]];
}
- (IBAction)jumpScrollview:(id)sender {
    [self jump:[[ScrollViewController alloc] init]];
}
- (IBAction)jumSecondView:(id)sender {
    [self jump:[[SecondViewController alloc] init]];
}
- (IBAction)junpThirdView:(id)sender {
    [self jump:[[ThirdViewController alloc] init]];
}
- (IBAction)jumpTableViewIndex:(id)sender {
    [self jump:[[TableViewIndexsController alloc] init]];
}
- (IBAction)jumpTableViewCustonCell:(id)sender {
    [self jump:[[TableViewCustonCellViewController alloc] init]];
}
- (IBAction)jumpTableViewDiffCell:(id)sender {
    [self jump:[[TableViewDiffCellViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}
@end
