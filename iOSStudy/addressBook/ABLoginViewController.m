//
//  ABLoginViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABLoginViewController.h"
#import "ABTableViewController.h"
#import "MBProgressHUD.h"

@interface ABLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UISwitch *savePwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ABLoginViewController
NSUserDefaults * userDefaults;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"王大静的通讯录";
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self.usernameTF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    self.usernameTF.text = [userDefaults objectForKey:@"username"];
    self.pwdTF.text = [userDefaults objectForKey:@"pwd"];
    [self textChange];
    
    self.autoLoginSwitch.on = [userDefaults boolForKey:@"autologin"];
    self.savePwdSwitch.on = [userDefaults boolForKey:@"savepwd"];
    
    if(self.autoLoginSwitch.on){
        [self doLogin:nil];
    }
}

#pragma mark - 按钮事件监听
- (IBAction)savePwdSwitchChange:(UISwitch *)uiSwitch {
    if(!uiSwitch.on){
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}
- (IBAction)autoLoginSwitchChage:(UISwitch *)uiSwitch {
    if(uiSwitch.on){
        [self.savePwdSwitch setOn:YES animated:YES];
    }
}

- (IBAction)doLogin:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"登录...";
    //延迟执行任务(0.5秒)
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //登录的逻辑处理
        if([self.usernameTF.text isEqualToString:@"axb"] && [self.pwdTF.text isEqualToString:@"123"]){
            //本地缓存相关信息
            [userDefaults setBool:self.autoLoginSwitch.on forKey:@"autologin"];
            [userDefaults setBool:self.savePwdSwitch.on forKey:@"savepwd"];
            [userDefaults setObject:self.usernameTF.text forKey:@"username"];
            if(self.savePwdSwitch.on){
                [userDefaults setObject:self.pwdTF.text forKey:@"pwd"];
            }else{
                [userDefaults removeObjectForKey:@"pwd"];
            }
            [userDefaults synchronize];
            
            ABTableViewController *abTableViewController = [[ABTableViewController alloc] init];
            abTableViewController.username = self.usernameTF.text;
            
            [self jumpVC:abTableViewController];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    });
}

/**
 跳转到下一个页面，并关闭当前页面
 @param vc   要跳转到的下一页viewController
 */
-(void)jumpVC:(UIViewController *)vc{
    NSArray *vcs = self.navigationController.viewControllers;
    NSMutableArray *newVCS = [NSMutableArray array];
    if ([vcs count] > 0) {
        for (int i=0; i < [vcs count]-1; i++) {
            [newVCS addObject:[vcs objectAtIndex:i]];
        }
    }
    [newVCS addObject:vc];
    [self.navigationController setViewControllers:newVCS animated:YES];
}

#pragma mark - 输入框值变化监听处理
- (void)textChange{
    //如果账号密码都不为空，则登录按钮可点击
    self.loginButton.enabled = self.usernameTF.text.length && self.pwdTF.text.length;
}
@end
