//
//  BaseUIFrameViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "BaseUIFrameViewController.h"
#import "BaseMainViewController.h"
#import "BaseConstactsViewController.h"
#import "DynamicViewController.h"

@interface BaseUIFrameViewController ()

@end

@implementation BaseUIFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)loadControllers{
    BaseMainViewController *mainVC = [[BaseMainViewController alloc] init];
    mainVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"add_normal.png"] selectedImage:[UIImage imageNamed:@"add_selected.png"]];
    
    //自定义导航控制器
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    //不设置为NO的话，iOS7 之后导航栏默认会遮挡UIViewController的内容
    mainNC.navigationBar.translucent = NO;
    
    
    BaseConstactsViewController *contactsVC = [[BaseConstactsViewController alloc] init];
    contactsVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"联系人" image:[UIImage imageNamed:@"add_normal.png"] selectedImage:[UIImage imageNamed:@"add_selected.png"]];
    //自定义导航控制器
    UINavigationController *contactsNC = [[UINavigationController alloc] initWithRootViewController:contactsVC];
    //不设置为NO的话，iOS7 之后导航栏默认会遮挡UIViewController的内容
    contactsNC.navigationBar.translucent = NO;
    
    DynamicViewController *dynamicVC = [[DynamicViewController alloc] init];
    dynamicVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:[UIImage imageNamed:@"add_normal.png"] selectedImage:[UIImage imageNamed:@"add_selected.png"]];
    //自定义导航控制器
    UINavigationController *dynamicNC = [[UINavigationController alloc] initWithRootViewController:dynamicVC];
    //不设置为NO的话，iOS7 之后导航栏默认会遮挡UIViewController的内容
    dynamicNC.navigationBar.translucent = NO;

    //添加控制器
    self.viewControllers = @[mainNC,contactsNC,dynamicNC];
}
@end
