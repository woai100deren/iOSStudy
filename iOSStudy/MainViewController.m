//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jumpTableView:(id)sender {
    //跳转到tableView
    [self.navigationController pushViewController:[[TableViewController alloc] init] animated:YES];
}

@end
