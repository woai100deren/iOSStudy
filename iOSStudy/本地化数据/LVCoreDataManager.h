//
//  LVCoreDataManager.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define kLVCoreDataManager [LVCoreDataManager sharedManager]

NS_ASSUME_NONNULL_BEGIN

@interface LVCoreDataManager : NSObject
/* 提供一个创建单例的方法
 */
+ (instancetype)sharedManager;

/* 提供一个创建数据库并保存的方法
 */
- (void)save;

/* 管理对象上下文 */
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;

/*  管理对象模型 */
@property (nonatomic,strong)NSManagedObjectModel *managedObjectModel;

/* 持久存储调度器 */
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

NS_ASSUME_NONNULL_END
