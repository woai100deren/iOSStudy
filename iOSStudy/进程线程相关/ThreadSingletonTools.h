//
//  ARC和MRC混合的单例模式
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadSingletonTools : NSObject<NSCopying,NSMutableCopying>
/**
 单例模式，方法的命名规范：
 share+类名 | default+类名 | share | default | 类名
 */
+(instancetype)shareThreadSingletonTools;
@end

NS_ASSUME_NONNULL_END
