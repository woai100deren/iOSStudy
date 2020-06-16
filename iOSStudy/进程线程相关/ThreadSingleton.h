//
//  ThreadSingleton.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

//说明：name为传入的参数，##name表示在后面拼接传入的name参数值。比如传入ABC，则最后变为shareBC
#define ThreadSingletonH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)
//条件满足ARC
#define ThreadSingletonM(name) static id _tools;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _tools = [super allocWithZone:zone];\
    });\
    return _tools;\
}\
+ (instancetype)share##name{\
    return [[self alloc] init];\
}\
- (id)copyWithZone:(nullable NSZone *)zone{\
    return _tools;\
}\
- (id)mutableCopyWithZone:(nullable NSZone *)zone{\
    return _tools;\
}
#else
//MRC
#define ThreadSingletonM(name) static id _tools;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _tools = [super allocWithZone:zone];\
    });\
    return _tools;\
}\
+ (instancetype)share##name{\
    return [[self alloc] init];\
}\
- (id)copyWithZone:(nullable NSZone *)zone{\
    return _tools;\
}\
- (id)mutableCopyWithZone:(nullable NSZone *)zone{\
    return _tools;\
}\
-(oneway void)release{\
}\
-(instancetype)retain{\
    return _tools;\
}\
-(NSInteger)retainCount{\
    return MAXFLOAT;\
}
#endif
