//
//  NetNSURLSessionBigDownloadViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetNSURLSessionFileDownloadViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface NetNSURLSessionFileDownloadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation NetNSURLSessionFileDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSURLSession文件下载";
}
- (IBAction)download:(id)sender {
    NSString *url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    //该方法内部已经实现了，边接收数据，边写入沙盒的tmp文件中
    //location 文件存储到本地的路径
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",location);
        //拼接文件全路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        //文件剪切
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        NSLog(@"文件全路径：%@",fullPath);
        //这是在子线程，需要回到主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label.text = fullPath;
            [self.imageView sd_setImageWithURL:[NSURL fileURLWithPath:fullPath]];
        }];
    }];
    [downloadTask resume];
}
@end
