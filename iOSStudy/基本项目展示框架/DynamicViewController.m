//
//  DynamicViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DynamicViewController.h"

@interface DynamicViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.title = @"动态";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.lightGrayColor;
}

-(void)goBack{
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.backgroundColor = UIColor.whiteColor;
    //哪一组indexPath.section，哪一组的哪一行indexPath.row
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld行",indexPath.section+1,indexPath.row+1];
    return cell;
}
@end
