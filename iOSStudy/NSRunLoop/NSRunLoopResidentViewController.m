//
//  NSRunLoopResidentViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NSRunLoopResidentViewController.h"

@interface NSRunLoopResidentViewController ()
@property(strong,nonatomic)NSThread *thread;
@end

@implementation NSRunLoopResidentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSRunLoop常驻线程";
}
- (IBAction)createThread:(id)sender {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [thread start];
    self.thread = thread;
}
- (IBAction)continueExcute:(id)sender {
    [self performSelector:@selector(task2) onThread:self.thread withObject:nil waitUntilDone:YES];
}
-(void)task1{
    NSLog(@"task1----%@",[NSThread currentThread]);
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    //常驻线程的几种方法
    //第一种方式：为了保证runLoop不退出，才创建了一个NSTimer。但是NSTimer毫无其他意义
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
//    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //第二种方式，添加一个port。这个port即为source
    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
    
    [runLoop run];
    //如果没有打印，就说明线程在运行
    NSLog(@"------end------");
}
-(void)task2{
    NSLog(@"task2----%@",[NSThread currentThread]);
}
-(void)timeRun{
    NSLog(@"timeRun----%@",[NSThread currentThread]);
}
@end
