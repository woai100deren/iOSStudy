//
//  ViewController.m
//  iOSPhoneStudy
//
//  Created by 王静 on 2020/5/26.
//  Copyright © 2020 王静. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"表格控制器";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //设置每一组头部高度
    self.tableView.sectionHeaderHeight = 80;
    //设置每一行cell的高度
    self.tableView.rowHeight = 100;
    //设置分割线颜色
    self.tableView.separatorColor = UIColor.blueColor;
    //设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //如下是针对整个列表的头部和尾部设置view
    self.tableView.tableHeaderView = [[UISwitch alloc] init];
    self.tableView.tableFooterView = [[UISwitch alloc] init];
}

#pragma mark - UITableViewDataSource
//告诉tableView有几组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

//告诉tableView每组有多少行数据(此方法不实现，就默认表示列表只有一组数据)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){//第0组
        return 3;
    }else if(section == 1){//第一组
        return 8;
    }else if(section == 2){//第一组
        return 8;
    }else{//第一组
        return 4;
    }
}

//每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //哪一组indexPath.section，哪一组的哪一行indexPath.row
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld行",indexPath.section+1,indexPath.row+1];
    
    cell.detailTextLabel.text = @"描述1111111111111111111111111111111111111111111111111111";
    cell.detailTextLabel.textColor = UIColor.redColor;
    //设置cell右边的指示模式
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置cell右边的另外一种方式,accessoryView优先级>accessoryType优先级
    cell.accessoryView = [[UISwitch alloc] init];
    cell.imageView.image = [UIImage imageNamed:@"car"];
    
    //选中效果的style,ios7之后，UITableViewCellSelectionStyleGray，UITableViewCellSelectionStyleDefault，UITableViewCellSelectionStyleBlue都是灰色
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    //设置cell的背景颜色
//    cell.backgroundColor = UIColor.redColor;
    
    //设置cell的背景view，backgroundView优先级大于backgroundColor
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.greenColor;
    cell.backgroundView = view;
    return cell;
}

//每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"aaaa头";
    }else{
        return @"bbbb头";
    }
}

//每一组的尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 0){
        return @"aaaa尾";
    }else{
        return @"bbbb尾";
    }
}

#pragma mark - UITableViewDelegate
//选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中第%ld组，第%ld行",indexPath.section+1,indexPath.row+1);
}
//取消选中某一行
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选中第%ld组，第%ld行",indexPath.section+1,indexPath.row+1);
}
//设置每一组的头部控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIButton buttonWithType:UIButtonTypeContactAdd];
}
//设置每一组的尾部控件
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}
@end
