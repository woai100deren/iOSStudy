//
//  NetworkMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetworkMainViewController.h"
#import "NetNSURLSessionViewController.h"
#import "NetNSURLSessionDelegateViewController.h"

@interface NetworkMainViewController ()

@end

@implementation NetworkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网络请求相关";
}
- (IBAction)urlSession:(id)sender {
    [self jump:[[NetNSURLSessionViewController alloc] init]];
}
- (IBAction)urlSessionDelegate:(id)sender {
    [self jump:[[NetNSURLSessionDelegateViewController alloc] init]];
}

-(void)jump:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
