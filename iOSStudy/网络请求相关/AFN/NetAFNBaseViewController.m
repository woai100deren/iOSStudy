//
//  NetAFNBaseViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NetAFNBaseViewController.h"
#import "AFNetworking.h"

@interface NetAFNBaseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *getResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *postResultLabel;

@end

@implementation NetAFNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"AFN基本请求";
}
- (IBAction)request:(id)sender {
    [self getRequest];
    [self postRequest];
}
-(void)getRequest{
    NSString *url = @"http://127.0.0.1:8080/getUserInfo";
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送请求
    [manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.getResultLabel.text = [NSString stringWithFormat:@"%@",responseObject];
//        self.getResultLabel.text = @"请求成功";
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
//        if (body) {
//        }
        self.getResultLabel.text = @"请求失败";
    }];
}

-(void)postRequest{
    NSString *url = @"http://127.0.0.1:8080/login";
    NSDictionary *dic = @{@"username":@"wangjing",
                          @"password":@"123"
                        };
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:dic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.postResultLabel.text = [NSString stringWithFormat:@"%@",responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.postResultLabel.text = @"请求失败";
    }];
}
@end
