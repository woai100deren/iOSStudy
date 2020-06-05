//
//  LocalValueSQLiteViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValueSQLiteViewController.h"
#import "SqliteTool.h"
#import "LocalValueModel.h"

@interface LocalValueSQLiteViewController ()
@property(nonatomic,strong)SqliteTool *sqliteTool;
@end

@implementation LocalValueSQLiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SQLite方式";
    self.sqliteTool = [SqliteTool shareinstance];
}

- (IBAction)createTabel:(id)sender {
    if([self.sqliteTool openSqliteDB]){
        //primary key 是主键的意思,主健在当前表里数据是唯一的,不能重复,可以唯一标识一条数据,一般是整数
        //autoincrement自增,为了让主键不重复,会让主键采用自增的方式
        //if not exists 如果没有表才会创建,防止重复创建覆盖之前数据
        BOOL result = [self.sqliteTool execSql:@"create table if not exists user(number integer primary key autoincrement,name text,age integer)"];
        NSLog(@"创建表user：%@",result?@"成功":@"失败");
    }
}
- (IBAction)insertData:(id)sender {
    LocalValueModel *model = [LocalValueModel modelWithName:@"张三" andAge:10];
    if([self.sqliteTool openSqliteDB]){
        NSString *sql=[NSString stringWithFormat:@"insert into user (name,age) values ('%@','%d')" ,model.name,model.age];
        [self.sqliteTool execSql:sql];
    }
}
- (IBAction)modifyData:(id)sender {
    LocalValueModel *model = [LocalValueModel modelWithName:@"张三" andAge:15];
    if([self.sqliteTool openSqliteDB]){
        NSString *sql= [NSString stringWithFormat:@"update user set age=%d where name='%@'",model.age,model.name];
        [self.sqliteTool execSql:sql];
    }
}
- (IBAction)deleteData:(id)sender {
    LocalValueModel *model = [LocalValueModel modelWithName:@"张三" andAge:18];
    if([self.sqliteTool openSqliteDB]){
        NSString *sql=[NSString stringWithFormat:@"delete from user where name='%@'",model.name];
        [self.sqliteTool execSql:sql];
    }
}

- (void)dealloc
{
    [self.sqliteTool closeSqliteDB];
}
@end
