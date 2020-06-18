//
//  NSURLSessionUploadFileViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NSURLSessionUploadFileViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "NetResultModel.h"

//分隔符
#define AXBBoundary @"AXB"
//换行
#define AXBEnter [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
//NSString转NSData
#define AXBEncode(string) [string dataUsingEncoding:NSUTF8StringEncoding]

@interface NSURLSessionUploadFileViewController ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation NSURLSessionUploadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLSession上传文件";
}
- (IBAction)uploadFile:(id)sender {
    NSString *url = @"http://127.0.0.1:8080/upload";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    //3、设置请求头
    NSString *head = [NSString stringWithFormat:@"multipart/form-data;boundary=%--@", AXBBoundary];
    [request setValue:head forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:[self getBodyData] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
        NetResultModel *result = [[NetResultModel alloc] initWithString:json error:nil];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:result.filePath]];
    }];
    
    [uploadTask resume];
}
/**
 上传一张图片
 */
-(NSData *)getBodyData{
    NSMutableData *data = [NSMutableData data];

    //1、开始标记
    //--
    [data appendData:AXBEncode(@"--")];
    //boundary
    [data appendData:AXBEncode(AXBBoundary)];
    //换行符
    [data appendData:AXBEnter];
    //文件参数名 Content-Disposition: form-data; name="myfile"; filename="wall.jpg"
    [data appendData:AXBEncode(@"Content-Disposition:form-data; name=\"uploadFile\"; filename=\"nv.png\"")];
    //换行符
    [data appendData:AXBEnter];
    //Content-Type 上传文件的类型 MIME
    [data appendData:AXBEncode(@"Content-Type:image/jpeg")];
    //换行符
    [data appendData:AXBEnter];
    //换行符
    [data appendData:AXBEnter];
    //2、上传的文件数据

    //图片数据  并且转换为Data
    UIImage *image = [UIImage imageNamed:@"nv"];
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    [data appendData:imagedata];
    //换行符
    [data appendData:AXBEnter];

    //3、结束标记
    //--
    [data appendData:AXBEncode(@"--")];
    //boundary
    [data appendData:AXBEncode(AXBBoundary)];
    //--
    [data appendData:AXBEncode(@"--")];
    //换行符
    [data appendData:AXBEnter];

    return data;
}

#pragma mark -NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{

    //设置进度条
    self.progressLabel.text = [NSString stringWithFormat:@"上传进度：%.2f%%",100.0f * totalBytesSent / totalBytesExpectedToSend];
}
@end
