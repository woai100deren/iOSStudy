//
//  UIApplicationStudyViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/1.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "UiapplicationStudyViewController.h"
#import "SingleObject.h"

@interface UiapplicationStudyViewController ()

@end

@implementation UiapplicationStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UIApplication学习";
    
//    UIApplication *application = [UIApplication sharedApplication];
    
    SingleObject *singleObject1 = [SingleObject shareSingleObject];
    SingleObject *singleObject2 = [SingleObject shareSingleObject];
//    SingleObject *singleObject3 = [[SingleObject alloc] init];
    NSLog(@"%p---%p",singleObject1,singleObject2);
}

#pragma mark - 按钮点击事件相关
- (IBAction)setTipsIcon:(id)sender {
    //设置桌面图标右上角的未读数字
    UIApplication *application = [UIApplication sharedApplication];
    UIUserNotificationSettings *set = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:set];
    application.applicationIconBadgeNumber = 10;
}
- (IBAction)setInternalState:(id)sender {
    //设置请求网络状态
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
}
- (IBAction)setStatusBar:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    //隐藏状态栏（application来设置的话，是整个app统一管理）。ios7之后，默认是由每个viewcontroller来自行管理。如果要application统一管理，需要在info.plist中的Supported interface orientations节点下，添加View controller-based status bar appearance为NO。
    application.statusBarHidden = NO;
    application.statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)openUrl:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    
    //打电话
//    [application openURL:[NSURL URLWithString:@"tel://10086"]];
    //发短信
    [application openURL:[NSURL URLWithString:@"sms://10086"]];
    //发邮件
//    [application openURL:[NSURL URLWithString:@"mailto://10086@qq.com"]];
    //打开网页
//    [application openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
}

#pragma mark - viewcontroller管理状态栏相关
//viewcontroller自行管理时，状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//viewcontroller自行管理时，状态栏是否隐藏
- (BOOL)prefersStatusBarHidden{
    return NO;
}
@end
