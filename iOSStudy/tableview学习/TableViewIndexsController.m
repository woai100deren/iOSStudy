//
//  TableViewIndexsController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TableViewIndexsController.h"
#import "CarGroup.h"

@interface TableViewIndexsController ()<UITableViewDataSource>
@property(nonatomic,strong)NSArray *carGroup;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewIndexsController

- (NSArray *)carGroup{
    if(!_carGroup){
        //加载字典
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars.plist" ofType:nil]];
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for(NSDictionary *carGroupDict in dictArray){
            [temp addObject:[CarGroup carGroupwithDict:carGroupDict]];
        }
        
        _carGroup = temp;
    }
    return _carGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    //给索引文字改颜色
    self.tableView.sectionIndexColor = UIColor.redColor;
    //给整个索引垂直列表赋值背景颜色
    self.tableView.sectionIndexBackgroundColor = UIColor.grayColor;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.carGroup.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CarGroup *group = self.carGroup[section];
    return group.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"car";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    CarGroup *group = self.carGroup[indexPath.section];
    cell.textLabel.text = group.cars[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CarGroup *group = self.carGroup[section];
    return  group.title;
}

//列表旁边的垂直索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //传统写法
//    NSMutableArray *titles = [[NSMutableArray alloc] init];
//    for(CarGroup *carGroup in self.carGroup){
//        [titles addObject:carGroup.title];
//    }
//    return titles;
    
    //KVC快捷写法
    return [self.carGroup valueForKey:@"title"];
}
@end
