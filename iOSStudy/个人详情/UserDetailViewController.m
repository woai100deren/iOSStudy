//
//  UserDetailViewController.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "UserDetailViewController.h"

#define oriOfftY -240
#define imageHeight 200
#define yellowViewHeight 40

@interface UserDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraints;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人详情";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //以下是让tableview显示初始位置跟navigationController顶部持平
    //是否延伸到包含不透明的状态栏。
    self.extendedLayoutIncludesOpaqueBars = YES;
    //不让系统自动设置偏移量
    if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
    
    self.navigationController.navigationBar.alpha = 0;

    self.tableView.contentInset = UIEdgeInsetsMake(self.imageView.bounds.size.height+self.yellowView.bounds.size.height, 0, 0, 0);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //哪一组indexPath.section，哪一组的哪一行indexPath.row
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row+1];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y - oriOfftY;
    CGFloat h = imageHeight - offsetY;
    if(offsetY>(imageHeight-[[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.bounds.size.height)){
        
        h = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.bounds.size.height;
    }
    
    self.imageHeightConstraints.constant = h;

    
    CGFloat alpha = offsetY/(imageHeight - self.navigationController.navigationBar.bounds.size.height - yellowViewHeight);
        self.navigationController.navigationBar.alpha = alpha;
}

@end
