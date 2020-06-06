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
#import "ShoppingCartViewController.h"
#import "UiapplicationStudyViewController.h"
#import "PickViewController.h"
#import "PickViewUseViewController.h"
#import "ABLoginViewController.h"
#import "WKWebViewController.h"
#import "DeliverValueFirstViewController.h"
#import "LocalValueMainViewController.h"
#import "UserDetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

//当控制加载完毕时
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    //去掉返回文字
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}
//当控制器即将显示时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//当控制器显示完毕时
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
//当控制器view将要布局子控件的时候
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
//当控制器view布局子控件完毕时
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
//当控制器即将消失时
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
//当控制器消失完毕时
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
- (IBAction)jumpShoppingCartView:(id)sender {
    [self jump:[[ShoppingCartViewController alloc] init]];
}
- (IBAction)jumpUIApplicationStudy:(id)sender {
    [self jump:[[UiapplicationStudyViewController alloc] init]];
}
- (IBAction)jumpPickView:(id)sender {
    [self jump:[[PickViewController alloc] init]];
}
- (IBAction)jumpPickViewUse:(id)sender {
    [self jump:[[PickViewUseViewController alloc] init]];
}
- (IBAction)jumpAddressBookDemo:(id)sender {
    [self jump:[[ABLoginViewController alloc] init]];
}
- (IBAction)jumpWKWebView:(id)sender {
    [self jump:[[WKWebViewController alloc] init]];
}
- (IBAction)jumpBackCarryValue:(id)sender {
    [self jump:[[DeliverValueFirstViewController alloc] init]];
}
- (IBAction)jumpLocalValue:(id)sender {
    [self jump:[[LocalValueMainViewController alloc] init]];
}
- (IBAction)jumpUserDetail:(id)sender {
    [self jump:[[UserDetailViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}
@end
