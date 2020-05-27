//
//  AppDelegate.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在Xcode11创建的项目中，需要自行给AppDelegate添加属性window
    //自定义Window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //自定义导航控制器
    UINavigationController *rootNavgationController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    //导航控制是rootViewController
    self.window.rootViewController = rootNavgationController;
    //现实Window
    [self.window makeKeyAndVisible];
    return YES;
}
@end
