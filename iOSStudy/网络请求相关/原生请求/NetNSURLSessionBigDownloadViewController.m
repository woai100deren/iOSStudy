//
//  NetNSURLSessionBigDownloadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetNSURLSessionBigDownloadViewController.h"
#import "QDDownloadProgressView.h"

@interface NetNSURLSessionBigDownloadViewController ()<NSURLSessionDownloadDelegate>
@property(strong,nonatomic)NSURLSessionDownloadTask *task;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet QDDownloadProgressView *progressView;
@property (strong,nonatomic) NSData *resumeData;
@property (strong,nonatomic) NSURLSession *session;
@end

@implementation NetNSURLSessionBigDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLSession大文件下载";
}
- (IBAction)downloadMovie:(id)sender {
    if(self.task){
        //说明正有任务在执行
        NSLog(@"有任务正在执行");
        return;
    }
    NSString *url = @"http://clientsys.aslkt.com/uploads/apk/2020/06/13/aslkt-student-release_V2.1.1_202006131335.apk";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
    
    [task resume];
    self.task = task;
}
/**
 暂停是可以恢复的
 */
- (IBAction)pauseDownload:(id)sender {
    NSLog(@"#######暂停下载#######");
    [self.task suspend];
}
- (IBAction)continueDownload:(id)sender {
    NSLog(@"#######恢复下载#######");
    if(self.resumeData){//取消
        //断点续传
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    }
    [self.task resume];
}
/**
 取消是不可以恢复的
 */
- (IBAction)cancelDownload:(id)sender {
    NSLog(@"#######取消下载#######");
//    [self.task cancel];
    [self.progressView setProgress:0];
    self.progressLabel.text = @"0.00%";
    
    //恢复下载的数据（可用于断点续传）
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
}

#pragma mark -NSURLSessionDownloadDelegate
/**
 当下载完成时调用
 @param location 文件下载到本地的临时存储路径
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"临时存储路径：%@",location);
    //拼接文件全路径
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    //文件剪切
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    NSLog(@"文件全路径：%@",fullPath);
    //这是在子线程，需要回到主线程刷新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.label.text = fullPath;
    }];
}

/**
 写数据
 
 @param session            会话对象
 @param downloadTask           下载任务
 @param bytesWritten 本次写入的数据大小
 @param totalBytesWritten 下载的数据总大小
 @param totalBytesExpectedToWrite 文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    CGFloat progress = totalBytesWritten * 1.0f / totalBytesExpectedToWrite;
    NSLog(@"文件进度：%f",progress);
    [self.progressView setProgress:progress];
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",progress * 100 ];
}

/**
 当恢复下载的时候调用
 @param fileOffset 从什么地方开始下载
 @param expectedTotalBytes 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                      didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

/**
 整个请求结束时候调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"整个下载过程结束");
    self.task = nil;
    //清理，否则可能内存泄漏
    [session invalidateAndCancel];
}
@end
