//
//  ThreadMyNSOperation.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadMyNSOperation.h"

@implementation ThreadMyNSOperation
/**
 必须重写main方法，告知要执行的任务
 */
- (void)main{
    NSLog(@"任务十六：%@",[NSThread currentThread]);
}
@end
