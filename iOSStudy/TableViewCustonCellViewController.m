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

@interface TableViewCustonCellViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy) NSArray *cars;
@end

@implementation TableViewCustonCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
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
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell setData:self.cars[indexPath.row]];
    return  cell;
}

-(NSArray*)getData{
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
    NSArray *carsArray = [Car mj_objectArrayWithKeyValuesArray:datas];
    return carsArray;
}
@end
