//
//  ThreadPthreadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/15.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadPthreadViewController.h"
#import <pthread.h>

@interface ThreadPthreadViewController ()

@end

@implementation ThreadPthreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"pthread";
}

- (IBAction)doInBackgroud:(id)sender {
    //创建线程对象
    pthread_t thread;
    //创建线程
    /**
     1.线程对象   传递地址
     2.线程的属性   NULL
     3.指向函数的指针
     4.函数需要接收的参数
     */
    pthread_create(&thread, NULL, task, NULL);
}
void *task(void *param){
    //耗时操作
    for(int i=0;i<10000;i++){
        NSLog(@"%d-------%@",i,[NSThread currentThread]);
    }
    NSLog(@"%@----------",[NSThread currentThread]);
    return NULL;
}
@end
