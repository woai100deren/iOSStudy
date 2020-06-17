//
//  NetworkMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetworkMainViewController.h"
#import "NetNSURLSessionViewController.h"

@interface NetworkMainViewController ()

@end

@implementation NetworkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网络请求相关";
}
- (IBAction)urlConnection:(id)sender {
    [self jump:[[NetNSURLSessionViewController alloc] init]];
}

-(void)jump:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
