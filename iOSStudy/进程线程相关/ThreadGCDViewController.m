//
//  ThreadGCDViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/15.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadGCDViewController.h"

@interface ThreadGCDViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ThreadGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多线程之GCD";
}

/**
 异步函数 + 并发队列，会开启多条线程，队列中的任务是异步执行的，并行执行
 */
- (IBAction) asyncConcurrent:(id)sender{
    //创建异步队列(新创建的，本身不存在)
    /**
     第一个参数：C语言的字符串，就是一个标识符，用来区分队列
     第二个参数：队列类型，DISPATCH_QUEUE_CONCURRENT：并发队列，DISPATCH_QUEUE_SERIAL：串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.dj.asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    //获得全局并发队列(不是新创建，本身存在的)
    /**
     第一个参数：优先级
     */
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"start --- ");
    
    //封装任务
    /**
     封装任务
     添加任务到队列中
     一个队列中，是可以添加多个任务的
     */
    dispatch_async(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    
    
    //栅栏函数(用在异步),不能使用全局并发队列。
    //栅栏函数的目的，只有执行完栅栏函数后，才能执行后面的任务
    dispatch_barrier_sync(queue, ^{
        dispatch_async(queue, ^{
            NSLog(@"++++++++++++++++++++++++");
        });
    });
    
    dispatch_async(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"end --- ");
}

/**
 异步函数 + 串行队列，会开启一条线程，队列中的任务是串行执行
 */
- (IBAction) asyncSerial:(id)sender{
    //创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.dj.asyncSerial", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"start --- ");
    
    //封装操作
    dispatch_async(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    NSLog(@"end --- ");
}

/**
 同步函数 + 并发队列，不会开线程，任务串行执行
 */
- (IBAction) syncConcurrent:(id)sender{
    //创建异步队列
    /**
     第一个参数：C语言的字符串，就是一个标识符，用来区分队列
     第二个参数：队列类型，DISPATCH_QUEUE_CONCURRENT：并发队列，DISPATCH_QUEUE_SERIAL：串行队列
     */
    dispatch_queue_t queue = dispatch_queue_create("com.dj.syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"start --- ");
    
    //封装任务
    /**
     封装任务
     添加任务到队列中
     一个队列中，是可以添加多个任务的
     */
    dispatch_sync(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"end --- ");
}

/**
同步函数 + 串行队列，不会开线程，串行执行
 */
- (IBAction) syncSerial:(id)sender{
    //创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.dj.syncSerial", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"start --- ");
    
    //封装操作
    dispatch_sync(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"end --- ");
}


/**
异步函数 + 主队列，所有任务在主线程中执行，不会开线程，串行执行
 */
- (IBAction) asyncMain:(id)sender{
    //创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"start --- ");
    
    //封装操作
    dispatch_async(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"end --- ");
}

/**
同步函数 + 主队列，死锁（程序卡死）。
 主队列特点：如果主队列发现当前主线程有任务在执行，那么主队列会暂停调度队列中的任务，直到主线程空闲为止
 
 如果创建一个线程来执行下面的代码，就不会出现死锁
 */
- (IBAction) syncMain:(id)sender{
    //创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"start --- ");
    
    //封装操作
    //立刻马上执行，如果我没有执行，那么后面的也别想执行
    dispatch_sync(queue, ^{
        NSLog(@"download1---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"end --- ");
}


- (IBAction)showImage:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *imagUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg";
        NSURL *url = [NSURL URLWithString:imagUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"%@----------",[NSThread currentThread]);
        
        
        
        //更新UI，下面两种方法都可以
        //异步执行
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
//            NSLog(@"更新UI%@----------",[NSThread currentThread]);
//        });
        
        //同步执行
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"更新UI%@----------",[NSThread currentThread]);
        });
    });
}

@end
