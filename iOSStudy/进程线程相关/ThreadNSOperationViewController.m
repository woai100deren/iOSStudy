//
//  ThreadNSOperationViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadNSOperationViewController.h"
#import "ThreadMyNSOperation.h"

@interface ThreadNSOperationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic)NSOperationQueue *queue;
@end

@implementation ThreadNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSOperation";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self use1];
    [self use2];
    [self use3];
    [self use4];
    [self use5];
    [self use6];
    [self use7];
    [self use8];
}
-(void)use1{
    //使用一，此种方式会在主线程执行，与直接调用runnable方法一样，所以没有意义。比如直接[self runnable:@"11"]
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务一："];
    [op1 start];
}
-(void)use2{
    //使用二，这种方式也没意义，也不会开线程，在主线程执行
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务二,%@",[NSThread currentThread]);
    }];
    [op2 start];
}
-(void)use3{
    //使用三，这种方式，如果任务数大于1，那么会开子线程执行，但是不一定是子线程执行，也可能是主线程执行
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务三,%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"任务四,%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"任务五,%@",[NSThread currentThread]);
    }];
    [op3 start];
}
-(void)use4{
    //使用四
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务六："];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务七："];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务八："];
    
    //主队列，串行队列
//    [NSOperationQueue mainQueue];
    //非主队列，很特殊，同时具备并行和串行的并发功能，默认是并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //添加后，内部就已经调用了start方法
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
-(void)use5{
    //使用五
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务九,%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务十,%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务十一,%@",[NSThread currentThread]);
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"任务十二,%@",[NSThread currentThread]);
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"任务十三,%@",[NSThread currentThread]);
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"任务十四,%@",[NSThread currentThread]);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperationWithBlock:^{
        NSLog(@"任务十五,%@",[NSThread currentThread]);
    }];
}
-(void)use6{
    //使用六
    ThreadMyNSOperation *op1 = [[ThreadMyNSOperation alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
}
-(void)use7{
    //使用七
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务十七："];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务十八："];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runnable:) object:@"任务十九："];
    
    //非主队列，很特殊，同时具备并行和串行的并发功能，默认是并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大并发数（同一时间，最多有多少个任务同时执行）。如果设置为1，就变成串行队列了。如果设置为0，不执行任何任务。如果设置为-1，表示不受限制，为最大并发数。
    queue.maxConcurrentOperationCount = 1;
    
    //添加后，内部就已经调用了start方法
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
-(void)use8{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务二十七,%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务二十八,%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务二十九,%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务三十,%@",[NSThread currentThread]);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    //需求：任务的执行顺序必须是3-1-4-2
    //添加操作依赖.
    //注意点，不能循环依赖，比如1依赖3，3依赖1.如果设置为相互依赖，谁都不会被执行。可以跨队列依赖。
    [op1 addDependency:op3];
    [op4 addDependency:op1];
    [op2 addDependency:op4];
    
    //操作监听，比如监听op3执行完成
    op3.completionBlock = ^{
        NSLog(@"任务二十九已执行完毕。%@",[NSThread currentThread]);
    };
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue2 addOperation:op4];
}

-(void)runnable:(NSString *)param{
    NSLog(@"%@,%@",param,[NSThread currentThread]);
}

- (IBAction)threadStart:(id)sender {
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十一,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十二,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十三,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十四,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op6 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十五,%d,%@",i,[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op7 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0;i<1000;i++){
            NSLog(@"任务二十六,%d,%@",i,[NSThread currentThread]);
        }
    }];
    
    //非主队列，很特殊，同时具备并行和串行的并发功能，默认是并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    self.queue = queue;
    
    //添加后，内部就已经调用了start方法
    [self.queue addOperation:op1];
    [self.queue addOperation:op2];
    [self.queue addOperation:op3];
    [self.queue addOperation:op4];
    [self.queue addOperation:op5];
    [self.queue addOperation:op6];
    [self.queue addOperation:op7];
}
- (IBAction)threadPause:(id)sender {
    //暂停，可以恢复继续执行。不能停止正在执行的任务。队列中的任务也是有状态的：执行完毕 | 正在执行 | 排队等待。
    [self.queue setSuspended:YES];
}
- (IBAction)threadContinue:(id)sender {
    //继续
    [self.queue setSuspended:NO];
}
- (IBAction)threadCancel:(id)sender {
    //取消，不可恢复。不能停止正在执行的任务
    //调用cancelAllOperations时，会自动调用所有NSOperation内部的cancel方法
    [self.queue cancelAllOperations];
}
- (IBAction)loadImage:(id)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSString *imagUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg";
        NSURL *url = [NSURL URLWithString:imagUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    [queue addOperation:op];
}
@end
