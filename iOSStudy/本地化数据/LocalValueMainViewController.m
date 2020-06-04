//
//  LocalValueMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValueMainViewController.h"
#import "LocalValuePlistViewController.h"
#import "LocalValuePreferenceViewController.h"
#import "LocalValueNSCodingViewController.h"
#import "LocalValueSQLiteViewController.h"
#import "LocalValueCoreDataViewController.h"

@interface LocalValueMainViewController ()

@end

@implementation LocalValueMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据本地持久化";
}
- (IBAction)jumpPlist:(id)sender {
    [self jump:[[LocalValuePlistViewController alloc]init]];
}
- (IBAction)jumpPreference:(id)sender {
    [self jump:[[LocalValuePreferenceViewController alloc]init]];
}
- (IBAction)jumpNSCoding:(id)sender {
    [self jump:[[LocalValueNSCodingViewController alloc]init]];
}
- (IBAction)jumpSQLite:(id)sender {
    [self jump:[[LocalValueSQLiteViewController alloc]init]];
}
- (IBAction)jumpCoreData:(id)sender {
    [self jump:[[LocalValueCoreDataViewController alloc]init]];
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}
@end
