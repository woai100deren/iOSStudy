//
//  TableViewCustonCellViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TableViewCustonCellViewController.h"
#import "MyTableViewCell.h"
#import "Car.h"
#import "MJExtension.h"

@interface TableViewCustonCellViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//copy拷贝的是不可变部分，所以用copy的话，不能对cars数据进行修改
@property(nonatomic,strong) NSMutableArray *cars;
@end

@implementation TableViewCustonCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.cars = [self getData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"tag";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        //一、通过代码方式创建的cell
//        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //二、通过xib的方式，需要加载xib来处理
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyTableViewCell class]) owner:nil options:nil] lastObject];
    }
    
    [cell setData:self.cars[indexPath.row]];
    return  cell;
}

#pragma mark - UITableViewDelegate
//ios11 以下的系统，下面这个方法（↓）必须实现，但是里面可以不做任何操作，如果不实现就不会有滑动功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.cars removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//如果想侧滑出来有多个操作按钮，需要实现（↓）这个方法，而且（↑）单个操作按钮会失效，但commitEditingStyle必须实现
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了关注 - %ld",indexPath.row);
        // 收回左滑出现的按钮(退出编辑模式)，不加此句，ios11以下不会自动缩回去
        tableView.editing = NO;
    }];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除 - %ld",indexPath.row);
        // 收回左滑出现的按钮(退出编辑模式)，不加此句，ios11以下不会自动缩回去
        tableView.editing = NO;
    }];
    return @[action2,action1];
}

#pragma mark - data

-(NSMutableArray*)getData{
    NSArray *datas = @[
        @{
            @"image" : @"car",
            @"title" : @"我是一辆车",
            @"subTitle":@"我是一辆车的描述我是一辆车的描述我是一辆车的描述我是一辆车的描述我是一辆车的描述"
        },
        @{
            @"image" : @"car",
            @"title" : @"我是二辆车",
            @"subTitle":@"我是二辆车的描述我是二辆车的描述我是二辆车的描述我是二辆车的描述我是二辆车的描述"
        },
        @{
            @"image" : @"car",
            @"title" : @"我是三辆车",
            @"subTitle":@"我是三辆车的描述我是三辆车的描述我是三辆车的描述我是三辆车的描述我是三辆车的描述"
        },
        @{
            @"image" : @"car",
            @"title" : @"我是四辆车",
            @"subTitle":@"我是四辆车的描述我是四辆车的描述我是四辆车的描述我是四辆车的描述我是四辆车的描述"
        },
        @{
            @"image" : @"car",
            @"title" : @"我是五辆车",
            @"subTitle":@"我是五辆车的描述我是五辆车的描述我是五辆车的描述我是五辆车的描述我是五辆车的描述"
        },
        @{
            @"image" : @"car",
            @"title" : @"我是六辆车",
            @"subTitle":@"我是六辆车的描述我是六辆车的描述我是六辆车的描述我是六辆车的描述我是六辆车的描述"
        }
    ];
    NSMutableArray *carsArray = [Car mj_objectArrayWithKeyValuesArray:datas];
    return carsArray;
}
@end
