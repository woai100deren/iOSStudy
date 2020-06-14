//
//  ImageCustomView.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/14.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageCustomView.h"

@implementation ImageCustomView

//返回当前uiview内部layer的类型
+(Class)layerClass{
    return [CAReplicatorLayer class];
}
@end
