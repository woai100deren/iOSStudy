//
//  main.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        //设置应用程序对象名称UIAppcalition或者它的子类名称，如果是nil，默认是UIAppcalition
        //第四个参数：设置代理。NSStringFromClass将类名转成字符串
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
