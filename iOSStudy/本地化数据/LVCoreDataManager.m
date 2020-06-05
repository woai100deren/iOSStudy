//
//  LVCoreDataManager.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LVCoreDataManager.h"

@implementation LVCoreDataManager
#pragma mark *** 创建一个管理数据的单例对象 ***
+ (instancetype)sharedManager{
    static LVCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LVCoreDataManager alloc]init];
    });
    return manager;
}

#pragma mark *** 获取沙盒路径的URL地址 ***

- (NSURL *) getDocumentsURL{
    /* 用这个文件管理的单例来生成沙盒路径的 URL */
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    /* 打印沙盒路径来验证是否创建数据库成功 */
    NSLog(@"%@",url);
    return url;
}


#pragma mark *** 懒加载各个属性 ***
// -------- 懒加载管理对象上下文 --------

- (NSManagedObjectContext *)managedObjectContext{
    
    /* NSPrivateQueueConcurrencyType 私有队列
     * NSMainQueueConcurrencyType    主队列
     */
    
    /* 一般使用主队列类型 */
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        /* 管理对象上下文还要设置持久存储调度器,这一点一定不能忘 */
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return _managedObjectContext;
}

// -------- 懒加载管理对象模型 --------
- (NSManagedObjectModel *)managedObjectModel{
    if (!_managedObjectModel) {
        /* 管理对象模型一定要给出".xcdatamodeld"文件的沙盒路径,但后缀名不能填写xcdatamodeld,而是 momd */
        _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"iOSStudy" withExtension:@"momd"]];
    }
    return _managedObjectModel;
}

// -------- 懒加载持久存储调度器 --------
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (!_persistentStoreCoordinator) {
        // -------- 初始化对象的步骤 --------
        /* 1. 初始化对象,给对象开辟内存空间 */
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
        /*
         // Persistent store types supported by Core Data:
         COREDATA_EXTERN NSString * const NSSQLiteStoreType NS_AVAILABLE(10_4, 3_0);
         COREDATA_EXTERN NSString * const NSXMLStoreType NS_AVAILABLE(10_4, NA);
         COREDATA_EXTERN NSString * const NSBinaryStoreType NS_AVAILABLE(10_4, 3_0);
         COREDATA_EXTERN NSString * const NSInMemoryStoreType NS_AVAILABLE(10_4, 3_0);
         */
        
        /**
         *  @author Tsaievan
         *
         *  Type:我们选择NSSQLiteStoreType
         *  configuration: 一般不配置
         *  URL: 需要选择数据库文件所在的 URL 地址:[[self getDocumentsURL] URLByAppendingPathComponent:@"sqlite.sqlite"]
         */
        
        /* 2. 给持久存储调度设置持久存储类型,并给出创建数据库文件的 URL 地址 */
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[[self getDocumentsURL] URLByAppendingPathComponent:@"sqlite.sqlite"] options:nil error:nil];
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark *** 保存数据 ***
- (void)save
{
    [self.managedObjectContext save:nil];
}

@end
