//
//  NetDownloadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/19.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetDownloadViewController.h"
#import "QDDownloadProgressView.h"
#import "AFNetworking.h"

@interface NetDownloadViewController ()
@property (weak, nonatomic) IBOutlet QDDownloadProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic) NSURLSessionDownloadTask *downloadTask;
@end

@implementation NetDownloadViewController
static NSString *url = @"http://clientsys.aslkt.com/uploads/apk/2020/06/13/aslkt-student-release_V2.1.1_202006131335.apk";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"AFN文件下载";
}
- (IBAction)startDL:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度回调
        // 非主线程，将UI操作切换到主线程进行
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progress = downloadProgress.completedUnitCount * 1.0f / downloadProgress.totalUnitCount;
            self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",progress * 100];
            self.progressView.progress = progress;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //targetPath 临时存储路径，response 响应头信息
        //返回值是要求用户告诉AFN框架，文件最终存储路径到哪里。
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成回调。filePath 实际最终存储文件路径，这个路径与destination返回的路径一致。
        //下载完成后的回调是在主线程
        self.resultLabel.text = [NSString stringWithFormat:@"下载完成，文件存储至：%@",filePath];
    }];
    
    [downloadTask resume];
    self.downloadTask = downloadTask;
}

- (IBAction)pauseDL:(id)sender {
    [self.downloadTask suspend];
}
- (IBAction)continueDL:(id)sender {
    [self.downloadTask resume];
}
- (IBAction)cancelDL:(id)sender {
    [self.downloadTask cancel];
    self.downloadTask = nil;
    [self.progressView setProgress:0];
    self.progressLabel.text = @"0.00%";
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [self cancelDL:nil];
    }
}
@end
