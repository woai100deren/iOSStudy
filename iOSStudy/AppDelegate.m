//
//  AppDelegate.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//app启动完毕时调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在Xcode11创建的项目中，需要自行给AppDelegate添加属性window
    //自定义Window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //自定义导航控制器
    UINavigationController *rootNavgationController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    //不设置为NO的话，iOS7 之后导航栏默认会遮挡UIViewController的内容
    rootNavgationController.navigationBar.translucent = NO;
    //导航控制是rootViewController
    self.window.rootViewController = rootNavgationController;
    self.window.backgroundColor = UIColor.whiteColor;
    //显示Window
    [self.window makeKeyAndVisible];
    
    // 启动图片延时: 2秒
    [NSThread sleepForTimeInterval:2];
    return YES;
}
//应用程序将要失去焦点时
- (void)applicationWillResignActive:(UIApplication *)application{
    
}
//应用程序获取焦点
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
//app进入后台时调用，比如按home键
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
//应用程序进入到前台时调用
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}
//app接收内存警告时调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
}
//应用程序退出时调用
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"iOSStudy"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
