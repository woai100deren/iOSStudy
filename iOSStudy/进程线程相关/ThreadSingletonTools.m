//
//  单例模式样例
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadSingletonTools.h"

@implementation ThreadSingletonTools
/**
 1、全局变量
 */
static ThreadSingletonTools *_tools;
/**
 2、重写allocWithZone
 此种重写allocWithZone的方式，是通过  alloc init方式创建对象时，保证单例
 因为alloc时，会最终调用到allocWithZone
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    //单例模式一
//    if(_tools == nil){
//        _tools = [super allocWithZone:zone];
//    }
    
    //单例模式二，加互斥锁解决线程安全问题
//    @synchronized (self) {
//        if(_tools == nil){
//            _tools = [super allocWithZone:zone];
//        }
//    }
    
    //单例模式三，本身就是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tools = [super allocWithZone:zone];
    });
    
    return _tools;
}

/**
 3、提供类方法
 类方法，实现单例模式
 */
+ (instancetype)shareThreadSingletonTools{
    return [[self alloc] init];
}

/**
 4、重写copyWithZone和mutableCopyWithZone
 严谨
 */
- (id)copyWithZone:(nullable NSZone *)zone{
    return _tools;
}


- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    return _tools;
}

#if __has_feature(objc_arc)
//条件满足ARC
#else
//MRC
/**
5、如果是MRC模式，则重写下面几个方法
*/
-(oneway void)release{
    //什么都不用做
}
-(instancetype)retain{
    return _tools;
}
-(NSInteger)retainCount{
    return MAXFLOAT;
}

#endif
@end
