//
//  LocalValueNSCodingViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValueNSCodingViewController.h"
#import "LocalValueModel.h"

@interface LocalValueNSCodingViewController ()

@end

@implementation LocalValueNSCodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSCoding方式";
    
    [self saveData];
}
-(void)saveData{
    LocalValueModel *model = [[LocalValueModel alloc]init];
    model.name = @"张三";
    model.age = 18;
    
    //获取沙盒中的tmp文件目录
    NSString *tempPath = NSTemporaryDirectory();
    //此处的文件名称后缀可以随便取，比如.data,.a,.b都可以
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"LocalValueModel.data"];
    //归档
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
    
    //读取归档数据
    LocalValueModel *readModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"读取的归档数据是：name=%@,age=%d",readModel.name,readModel.age);
}

@end
