//
//  TableViewDiffCellViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/28.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TableViewDiffCellViewController.h"
#import "Car.h"
#import "MyTableViewCell.h"
#import "MyTableViewDiffCell.h"
#import "MJExtension.h"

@interface TableViewDiffCellViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy) NSArray *cars;
@end

@implementation TableViewDiffCellViewController

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
    return self.cars.count*2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tag1";
    static NSString *ID2 = @"tag2";
    if(indexPath.row % 2 == 0){
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil){
            //一、通过代码方式创建的cell
    //        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            //二、通过xib的方式，需要加载xib来处理
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyTableViewCell class]) owner:self options:nil] lastObject];
        }
        
        [cell setData:self.cars[indexPath.row%2 == 0?indexPath.row/2:indexPath.row/2+1]];
        return  cell;
    }else{
        MyTableViewDiffCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyTableViewDiffCell class]) owner:nil options:nil] lastObject];
        }
        return  cell;
    }
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
