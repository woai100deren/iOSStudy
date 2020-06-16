//
//  ThreadBasicViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/12.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadBasicViewController.h"
#import "ThreadPthreadViewController.h"
#import "ThreadNSThreadViewController.h"
#import "ThreadGCDViewController.h"
#import "ThreadNSOperationViewController.h"

@interface ThreadBasicViewController ()

@end

@implementation ThreadBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thread相关的基本知识";
    
    //获得主线程
    NSThread *mainThread =[NSThread mainThread];
    NSLog(@"主线程：%@",mainThread);
    
    //获取当前线程
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"当前线程：%@",currentThread);
    
    //判断主线程
    BOOL isMainThread = [currentThread isMainThread];
    //1即为YES
    NSLog(@"当前线程是不是主线程：%d",isMainThread);
}
- (IBAction)pthread:(id)sender {
    [self jump:[[ThreadPthreadViewController alloc] init]];
}
- (IBAction)nsthread:(id)sender {
    [self jump:[[ThreadNSThreadViewController alloc] init]];
}
- (IBAction)gcd:(id)sender {
    [self jump:[[ThreadGCDViewController alloc] init]];
}
- (IBAction)nsoperation:(id)sender {
    [self jump:[[ThreadNSOperationViewController alloc] init]];
}
- (IBAction)downloadImages:(id)sender {
}

-(void)jump:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
