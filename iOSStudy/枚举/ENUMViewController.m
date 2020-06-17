//
//  ENUMViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ENUMViewController.h"

/**
 第一种写法
 */
typedef enum{
    TestTypeTop,
    TestTypeBottom,
}TestType;

/**
 第二种写法，定义类型
 */
typedef NS_ENUM(NSInteger,TestType2){
    TestType2Top,
    TestType2Bottom,
};

/**
 第三种写法，位移枚举
 这是C的写法
 一个参数可以传递多个值
 如果是位移枚举，观察第一个枚举值。如果该枚举值不为0，则可以传0做参数，那么效率最高，因为什么都不会做。
 */
typedef NS_OPTIONS(NSInteger, TestType3){
    TestType3Top = 1<<0,//1*2(0次方)
    TestType3Bottom = 1<<1,//1*2(1次方)
    TestType3Left = 1<<2,//1*2(2次方)
    TestType3Right = 1<<3,//1*2(3次方)
};

@interface ENUMViewController ()

@end

@implementation ENUMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"枚举示例";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test2:TestType2Top];
    [self test3:TestType3Top | TestType3Bottom ];
}

-(void)test2:(TestType2)testType{
    if(testType == TestType2Top){
        NSLog(@"test2-top");
    }
}
/**
 按位与 & 1&1=1 1&0=0 0&0=0 只要有0则为0
 按位或 |   1|1=1  1|0=1  0|0=0   只要有1则为1
 */
-(void)test3:(TestType3)testType{
    if(testType & TestType3Top){
        NSLog(@"test3-top");
    }
    if(testType & TestType3Bottom){
        NSLog(@"test3-bottom");
    }
}

@end
