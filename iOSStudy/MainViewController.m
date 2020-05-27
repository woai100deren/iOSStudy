//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"
#import "MasonryViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ScrollViewController.h"

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
    [self jump:[[TableViewController alloc] init]];
}
- (IBAction)jumpMasonry:(id)sender {
    [self jump:[[MasonryViewController alloc] init]];
}
- (IBAction)jumpScrollview:(id)sender {
    [self jump:[[ScrollViewController alloc] init]];
}
- (IBAction)jumSecondView:(id)sender {
    [self jump:[[SecondViewController alloc] init]];
}
- (IBAction)junpThirdView:(id)sender {
    [self jump:[[ThirdViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}
@end
