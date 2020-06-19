//
//  AXBHttpTool.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/19.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AXBHttpTool.h"

@implementation AXBHttpTool
+(void)get:(NSString *)url param:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError * error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}

+(NSURLSessionDataTask *)post:(NSString *)url param:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress){
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
    return task;
}
@end
