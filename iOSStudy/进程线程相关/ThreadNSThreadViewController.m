//
//  ThreadNSThreadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/15.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadNSThreadViewController.h"

@interface ThreadNSThreadViewController ()
@property(strong,nonatomic) NSThread *threadA;
@property(strong,nonatomic) NSThread *threadB;
@property(strong,nonatomic) NSThread *threadC;
@property(nonatomic,assign) NSInteger totleCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ThreadNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSThread";
}
- (IBAction)createThread:(id)sender {
    [self createThread1];
    [self createThread2];
    [self createThread3];
}
- (IBAction)threadSafe:(id)sender {
    self.totleCount = 100;
    self.threadA = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadB = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadC = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    
    self.threadA.name = @"threadA";
    self.threadB.name = @"threadB";
    self.threadC.name = @"threadC";
    [self.threadA start];
    [self.threadB start];
    [self.threadC start];
}
- (IBAction)threadCommunication:(id)sender {
    [self performSelectorInBackground:@selector(downloadImage) withObject:nil];
}
/**
 需手动启动线程
 线程的生命周期：当任务执行完毕后被释放掉
 */
-(void)createThread1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runnable:) object:@"ABC"];
    //给线程取名称
    thread.name = @"I'm current thread name";
    //线程优先级（取值范围0.0-1.0），1.0最高，默认0.5
    thread.threadPriority = 1.0;
    [thread start];
}
/**
 会自动启动线程
 */
-(void)createThread2{
    [NSThread detachNewThreadSelector:@selector(runnable:) toTarget:self withObject:@"分离子线程"];
}
-(void)createThread3{
    [self performSelectorInBackground:@selector(runnable:) withObject:@"开启一条后台线程"];
}
-(void)runnable:(NSString *)param{
    NSLog(@"param = %@---------%@",param,[NSThread currentThread]);
    [NSThread exit];
}

-(void)saleTicket{
    while (1) {
        //加锁保证线程安全（互斥锁）
        //锁是全局唯一
        @synchronized (self) {
            NSInteger count = self.totleCount;
            if(count > 0){
                for (int i=0; i<10000; i++) {
                    
                }
                self.totleCount = count - 1;
                NSLog(@"%@卖出去了一张票，还剩下%zd张票",[NSThread currentThread].name,self.totleCount);
            }else{
                NSLog(@"不要来了");
                break;
            }
        }
    }
}

-(void)downloadImage{
    NSDate *startTime = [NSDate date];
    //https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg
    NSString *imagUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg";
    NSURL *url = [NSURL URLWithString:imagUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
//    self.imageView.image = image;
    NSDate *endTime = [NSDate date];
    NSLog(@"耗时：%f",[endTime timeIntervalSinceDate:startTime]);
    
    //回到主线程第一种方法
    //最后参数，YES时，需要等待@selector方法执行完之后，再执行下面的105行代码。如果是NO，不需要等到@selector方法执行完
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    
    //回到主线程第二种方法
//    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    //回到主线程第三种方法，直接调用UIImageView的setImage方法
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    NSLog(@"---end---");
}
-(void)showImage:(UIImage *)image{
    self.imageView.image = image;
}
@end
