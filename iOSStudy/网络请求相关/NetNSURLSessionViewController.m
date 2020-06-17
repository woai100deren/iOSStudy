//
//  NetNSURLConnectionViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetNSURLSessionViewController.h"

@interface NetNSURLSessionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *getResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *postResultLabel;

@end

@implementation NetNSURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLConnection基本使用";
}
- (IBAction)requestUrl:(id)sender {
    [self getRequest];
    [self postRequest];
}
-(void)getRequest{
    //1.确定url
        NSString *url = @"http://127.0.0.1:8080/getUserInfo";
        //2.创建请求对象
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        //3.创建会话对象
        NSURLSession *session = [NSURLSession sharedSession];
        //4.创建task
        //第一个参数：请求对象
        //第二个参数：completionHandler 请求完成后的回调
        //          data：响应体信息
        //          response：响应头信息
        //          error：错误信息，当请求失败的时候，error有值
    //    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //        //6.解析数据
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //           self.resultLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //        }];
    //
    //    }];
        
        
        NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                       self.getResultLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }];
        }];
        
        
        //5.执行task
        [task resume];
}
-(void)postRequest{
    //1.确定url
    NSString *url = @"http://127.0.0.1:8080/login";
    //2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"susername=wangjing&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];

    //3.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //4.创建task
    //第一个参数：请求对象
    //第二个参数：completionHandler 请求完成后的回调
    //          data：响应体信息
    //          response：响应头信息
    //          error：错误信息，当请求失败的时候，error有值
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //6.解析数据
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           self.postResultLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }];

    }];
    
    //5.执行task
    [task resume];
}
@end
