//
//  SqliteTool.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SqliteTool : NSObject
+ (SqliteTool *)shareinstance;
- (BOOL)openSqliteDB;
- (BOOL)closeSqliteDB;
//执行sql
- (BOOL)execSql:(NSString *)sql;
//查看表中的数据
//- (NSMutableArray *)selectAll;
@end

NS_ASSUME_NONNULL_END
