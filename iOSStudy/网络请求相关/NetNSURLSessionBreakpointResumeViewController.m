//
//  NetNSURLSessionBreakpointResumeViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetNSURLSessionBreakpointResumeViewController.h"
#import "QDDownloadProgressView.h"

@interface NetNSURLSessionBreakpointResumeViewController ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet QDDownloadProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (strong,nonatomic) NSURLSessionDataTask *dataTask;
@property (strong,nonatomic) NSFileHandle *handle;
@property (assign,nonatomic) NSInteger currentSize;
@property (assign,nonatomic) NSInteger totalSize;
@property (strong,nonatomic) NSString *fullPath;

@end

@implementation NetNSURLSessionBreakpointResumeViewController
static NSString *url = @"http://clientsys.aslkt.com/uploads/apk/2020/06/13/aslkt-student-release_V2.1.1_202006131335.apk";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLSession断点续传";
    
    self.currentSize = [[NSUserDefaults standardUserDefaults] integerForKey:url];
}

- (NSURLSessionDataTask *)dataTask{
    if(!_dataTask){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        //设置断点续传的头，告诉服务器从哪里开始下载
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        _dataTask = [session dataTaskWithRequest:request];
    }
    return _dataTask;
}

- (IBAction)download:(id)sender {
    [self.dataTask resume];
}
- (IBAction)pauseDownload:(id)sender {
    [self.dataTask suspend];
}
- (IBAction)continueDownload:(id)sender {
    [self.dataTask resume];
}
- (IBAction)cancelDownload:(id)sender {
    [self.dataTask cancel];
    self.dataTask = nil;
    [self.progressView setProgress:0];
    self.progressLabel.text = @"0.00%";
}
- (IBAction)clearCache:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:url];
    self.currentSize = 0;
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        NSLog(@"返回了");
        [self cancelDownload:nil];
    }
}

#pragma mark -NSURLSessionDataDelegate
/**
 接收到服务器的响应 ，它默认会取消该请求
 @param session                          会话对象
 @param dataTask                        请求任务
 @param response                        响应头信息
 @param completionHandler    回调
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    NSLog(@"%s",__func__);
    //获得文件总大小
    //获得是本次请求的大小
    self.totalSize = response.expectedContentLength + self.currentSize;
    //拼接文件全路径
    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    if(self.currentSize == 0){
        //创建空文件
        [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes:nil];
    }
    //创建文件句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    //移动句柄指针到文件尾部
    [self.handle seekToEndOfFile];
    completionHandler(NSURLSessionResponseAllow);
}

/**
 接收到服务器返回的数据    调用多次
 @param session           会话对象
 @param dataTask        请求任务
 @param data                 本次接收到的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"%s",__func__);
    
    //写入数据到文件（内部会自动移动句柄）
    [self.handle writeData:data];
    //计算下载进度
    self.currentSize += data.length;
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentSize forKey:url];
    
    CGFloat progress = self.currentSize *1.0f / self.totalSize;
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",progress * 100];
}

/**
 请求结束或者失败时候调用
 @param session           会话对象
 @param task                 请求任务
 @param error               错误信息
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%@,%s",self.fullPath,__func__);
    //因为上面session设置的是在mainQueue进行请求
    [self.handle closeFile];
    self.handle = nil;
}
@end
