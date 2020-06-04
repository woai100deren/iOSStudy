//
//  ABTableViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABTableViewController.h"
#import "ABAddContactsViewController.h"
#import "ABContacts.h"
#import "MJExtension.h"
#import "ABTableViewCell.h"
#import "ABContactsDetailViewController.h"

@interface ABTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ABTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(toAdd)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self initDataArray];
}

- (void)setUsername:(NSString *)username{
    _username = username;
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",username];
}

- (void)initDataArray{
    //获取沙盒Document路径
    NSString *currentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [currentPath stringByAppendingPathComponent:@"addressBook.plist"];
    self.dataArray = [ABContacts mj_objectArrayWithFile:filePath];
    [self.tableView reloadData];
}

/**
 注销
 */
-(void)logout{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];

     UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self.navigationController popViewControllerAnimated:YES];
     }];
    
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:confirmAction];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
}
/**
 跳转到新增通讯录
 */
-(void)toAdd{
    [self.navigationController pushViewController:[[ABAddContactsViewController alloc]init] animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"contacts";
    
    ABTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ABTableViewCell class]) owner:nil options:nil] firstObject];
    }
    cell.abContacts = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ABContactsDetailViewController *detalVC = [[ABContactsDetailViewController alloc]init];
    [detalVC setData:self.dataArray[indexPath.row] inIndex:indexPath.row];
    [self.navigationController pushViewController:detalVC animated:YES];
}
@end
