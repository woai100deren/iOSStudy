//
//  NetResultModel.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/18.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetResultModel : JSONModel
@property(copy,nonatomic) NSString *resultCode;
@property(copy,nonatomic) NSString *resultMsg;
@property(copy,nonatomic) NSString *filePath;
@end

NS_ASSUME_NONNULL_END
