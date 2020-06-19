//
//  AXBHttpTool.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/19.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXBHttpTool : NSObject
/**
 发送一个get请求
 @param url 网络请求地址
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败的回调
 */
+(void)get:(NSString *)url param:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError * error))failure;

/**
 发送一个post请求
 @param url 网络请求地址
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败的回调
 */
+(NSURLSessionDataTask *)post:(NSString *)url param:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
