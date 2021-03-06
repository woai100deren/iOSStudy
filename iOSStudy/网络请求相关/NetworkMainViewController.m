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
#import "NetNSURLSessionFileDownloadViewController.h"
#import "NetNSURLSessionBigDownloadViewController.h"
#import "NetNSURLSessionBreakpointResumeViewController.h"
#import "NSURLSessionUploadFileViewController.h"
#import "NetAFNBaseViewController.h"
#import "NetDownloadViewController.h"
#import "AFNUploadViewController.h"

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
- (IBAction)urlSessionFileDownload:(id)sender {
    [self jump:[[NetNSURLSessionFileDownloadViewController alloc] init]];
}
- (IBAction)urlSessionBigDownload:(id)sender {
    [self jump:[[NetNSURLSessionBigDownloadViewController alloc] init]];
}
- (IBAction)breakpointResume:(id)sender {
    [self jump:[[NetNSURLSessionBreakpointResumeViewController alloc]init]];
}
- (IBAction)uploadFile:(id)sender {
    [self jump:[[NSURLSessionUploadFileViewController alloc] init]];
}
- (IBAction)afnBase:(id)sender {
    [self jump:[[NetAFNBaseViewController alloc] init]];
}
- (IBAction)afnDownload:(id)sender {
    [self jump:[[NetDownloadViewController alloc] init]];
}
- (IBAction)afnUpload:(id)sender {
    [self jump:[[AFNUploadViewController alloc] init]];
}

-(void)jump:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
