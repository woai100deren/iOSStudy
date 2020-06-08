//
//  TabBarSystemViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TabBarSystemViewController.h"
#import "MainViewController.h"
#import "SecondViewController.h"

@interface TabBarSystemViewController ()

@end

@implementation TabBarSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadControllers];
}

-(void)loadControllers{
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"add_normal.png"] selectedImage:[UIImage imageNamed:@"add_selected.png"]];
//    [self.tabBarController addChildViewController:mainVC];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"二页" image:[UIImage imageNamed:@"subtract_normal.png"] selectedImage:[UIImage imageNamed:@"subtract_selected.png"]];
//    [self.tabBarController addChildViewController:secondVC];
    
    //添加控制器
    self.viewControllers = @[mainVC,secondVC];
}

@end
