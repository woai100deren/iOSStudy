//
//  TableViewCustonCellViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TableViewCustonCellViewController.h"
#import "MyTableViewCell.h"

@interface TableViewCustonCellViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewCustonCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"tag";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    Car *car = [[Car alloc] init];
    car.image = @"car";
    car.title = @"则是一辆车";
    car.subTitle = @"则是一辆车则是一辆车则是一辆车则是一辆车则是一辆车则是一辆车则是一辆车则是一辆车则是一辆车";
    [cell setData:car];
    return  cell;
}
@end
