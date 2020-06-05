//
//  SqliteTool.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SqliteTool.h"
#import <sqlite3.h>

@implementation SqliteTool
sqlite3 *_dbPoint;  //用于保存数据库对象的地址

+ (SqliteTool *)shareinstance{
    static SqliteTool *tool = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        tool=[[SqliteTool alloc] init];
    });
    return tool;

}

/**
打开数据库，如果系统根据这个文件路径查找的时候有对应文件则直接打开数据库,如果没有则会创建一个相应的数据库
*/
- (BOOL)openSqliteDB{
    //存储到沙盒的tmp文件夹中
    NSString *sqitePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.sqlite"];
    int result = sqlite3_open([sqitePath UTF8String], &_dbPoint);//在指定路径下，创建一个数据，并将数据库的地址赋值给_dbPoint
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        NSLog(@"%@",sqitePath);
        return YES;
    }else{
        NSLog(@"数据库打开失败");
    }
    return NO;
}

/**
 关闭数据库
 */
- (BOOL)closeSqliteDB{
    int result = sqlite3_close(_dbPoint);
    if (result==SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        return YES;
        
    }else{
        NSLog(@"数据库关闭失败");
    }
    return NO;
}

/**
   创建一个存储列表。 一个数据库可以创建很多列表，用来存储不同的对象。
*/
- (BOOL)execSql:(NSString*)sql{
    //执行这条sql语句
    int result = sqlite3_exec(_dbPoint, [sql UTF8String], nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"执行成功");
        return YES;
    }else{
        NSLog(@"执行失败");
    }
    return NO;
}

///*
//查询逻辑
//1.先从本地的数据库中读取某张表里的所有数据
//2.然后逐条进行读取,对model进行赋值
//3.把已经赋值好得model放到数组中,并且返回
//4.在语句里*是通配符的意思,通过一个*相当于代替了表里的所有的字段名
//5.接下来需要定义一个跟随指针,它用来遍历数据库表中的每行数据
//6.第三个参数:查询语句字数限制,-1是没有限制
//*/
//
////查看表中的数据
//- (NSMutableArray *)selectAllModel{
//    NSString *sqlStr=@"select * from test";
//    sqlite3_stmt *stmt=nil;
//     int result=sqlite3_prepare_v2(_dbPoint, [sqlStr UTF8String], -1, &stmt, nil);//这个方法相当于把数据库和跟随指针关联,一同完成查询功能
//
//    NSMutableArray *modelArr = [NSMutableArray array];
//    //初始化学生类数组 获取遍历得到的数据
//    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
//        //开始遍历查询数据库的每一行数据
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            //让跟随指针进行遍历查询,如果没有行,才会停止循环
//            //满足条件,则逐列的读取内容
//            //第二个参数表示当前这列数据在表的第几列
//            const unsigned char *name = sqlite3_column_text(stmt, 1);
//            int age = sqlite3_column_int(stmt, 2);
//            //把列里的数据再进行类型的转换
//            NSInteger modelAge = age;
//            NSString *modelName = [NSString stringWithUTF8String:(const char *)name];
//            //给对象赋值,然后把对象放到数组里
//            TestModel *model = [[TestModel alloc] init];
//            model.name = modelName;
//            model.age = modelAge;
//            [modelArr addObject:model];
//        }
//    }else{
//         NSLog(@"查询失败");
//    }
//    return modelArr;
//}
@end
