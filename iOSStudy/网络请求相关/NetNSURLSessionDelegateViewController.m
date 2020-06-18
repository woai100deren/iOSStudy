//
//  NetNSURLSessionDelegateViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetNSURLSessionDelegateViewController.h"

@interface NetNSURLSessionDelegateViewController ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextView *resultLabel;
@property (strong,nonatomic) NSMutableData *fileData;
@end

@implementation NetNSURLSessionDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLSession代理";
}
- (IBAction)requestUrl:(id)sender {
    [self getRequest];
}

- (NSMutableData *)fileData{
    if(!_fileData){
        _fileData = [NSMutableData data];
    }
    return _fileData;
}

-(void)getRequest{
    NSString *url = @"http://t.weather.sojson.com/api/weather/city/101030100";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    [task resume];
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
    /**
     NSURLSessionResponseCancel = 0,//取消请求，默认
     NSURLSessionResponseAllow = 1,//接收
     NSURLSessionResponseBecomeDownload = 2,//变成下载任务
     NSURLSessionResponseBecomeStream //变成下载任务
     */
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
    //拼接数据
    [self.fileData appendData:data];
}

/**
 请求结束或者失败时候调用
 @param session           会话对象
 @param task                 请求任务
 @param error               错误信息
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%s",__func__);
    //6.解析数据
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.resultLabel.text = [[NSString alloc] initWithData:self.fileData encoding:NSUTF8StringEncoding];
    }];
}
@end
