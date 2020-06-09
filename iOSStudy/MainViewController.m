//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MainViewController.h"
#import "JumpModel.h"
#import "MJExtension.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *jumpModelsArray;
@end

@implementation MainViewController

- (NSArray *)jumpModelsArray{
    if(!_jumpModelsArray){
        _jumpModelsArray = [JumpModel mj_objectArrayWithFilename:@"MainJumpViews.plist"];
    }
    return _jumpModelsArray;
}

//当控制加载完毕时
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    //去掉返回文字
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
//当控制器即将显示时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//当控制器显示完毕时
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
//当控制器view将要布局子控件的时候
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
//当控制器view布局子控件完毕时
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
//当控制器即将消失时
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
//当控制器消失完毕时
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)modalJump:(UIViewController*) vc{
    //在presentViewController前为要弹出的VC设置这两条属性，否则modal方式弹出来的页面无法全屏
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.edgesForExtendedLayout = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 * @brief 将字符串转化为控制器.
 * @param str 需要转化的字符串.
 * @return 控制器(需判断是否为空).
 */
- (UIViewController*)stringChangeToClass:(NSString *)str {
    id vc = [[NSClassFromString(str) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jumpModelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    JumpModel *model = self.jumpModelsArray[indexPath.row];
    
    cell.textLabel.text = model.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JumpModel *model = self.jumpModelsArray[indexPath.row];
    
    UIViewController *controller = [self stringChangeToClass:model.controller];
    if([model.controller isEqualToString:@"ModalViewController"]){
        [self modalJump:controller];
    }else{
        [self jump:controller];
    }
}
@end
