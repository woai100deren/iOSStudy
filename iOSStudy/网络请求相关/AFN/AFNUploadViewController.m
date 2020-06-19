//
//  AFNUploadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/19.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AFNUploadViewController.h"
#import "AFNetworking.h"
#import "NetResultModel.h"
#import <SDWebImage/SDWebImage.h>

//分隔符
#define AXBBoundary @"AXB"
//换行
#define AXBEnter [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
//NSString转NSData
#define AXBEncode(string) [string dataUsingEncoding:NSUTF8StringEncoding]

@interface AFNUploadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation AFNUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"AFN文件上传";
}

- (IBAction)uploadFile:(id)sender {
    [self uploadFun2];
}

/**
 上传方案一，不推荐（原始写法）
 */
-(void)uploadFun1{
    NSString *url = @"http://127.0.0.1:8080/upload";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        request.HTTPMethod = @"POST";
        //3、设置请求头
        NSString *head = [NSString stringWithFormat:@"multipart/form-data;boundary=%--@", AXBBoundary];
        [request setValue:head forHTTPHeaderField:@"Content-Type"];
        
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:[self getBodyData] progress:^(NSProgress * _Nonnull uploadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置进度条
                self.progressLabel.text = [NSString stringWithFormat:@"上传进度：%.2f%%",100.0f * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
            });
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //        NSString *json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    //        NetResultModel *result = [[NetResultModel alloc] initWithString:json error:nil];
    //        [self.imageView sd_setImageWithURL:[NSURL URLWithString:result.filePath]];
        }];
        
        [uploadTask resume];
}

/**
 上传方案二
 */
-(void)uploadFun2{
    NSString *url = @"http://127.0.0.1:8080/upload";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *uploadTask = [manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //图片数据  并且转换为Data
        UIImage *image = [UIImage imageNamed:@"nv"];
        NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
        //使用formData拼接数据。如果是选中本地的一个文件，可以使用appendPartWithFileURL，直接传入文件url地址即可
        [formData appendPartWithFileData:imagedata name:@"uploadFile" fileName:@"nv.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置进度条
            self.progressLabel.text = [NSString stringWithFormat:@"上传进度：%.2f%%",100.0f * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
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

@end
