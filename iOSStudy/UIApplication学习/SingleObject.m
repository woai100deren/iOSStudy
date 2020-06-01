//
//  SingleObject.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/1.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SingleObject.h"

@implementation SingleObject
static SingleObject *_singleObject;
+ (void)load{
    _singleObject =[[SingleObject alloc] init];
}

+(instancetype)shareSingleObject{
    return _singleObject;
}


+ (instancetype)alloc{
    if(_singleObject){
        //自定义异常
        NSException *exception = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one SingleObject instance" userInfo:nil];
        //抛出异常
        [exception raise];
    }
    return [super alloc];
}

@end
