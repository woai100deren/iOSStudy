//
//  TableViewMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "TableViewMainViewController.h"
#import "TableViewController.h"
#import "TableViewIndexsController.h"
#import "TableViewCustonCellViewController.h"
#import "TableViewDiffCellViewController.h"
#import "ShoppingCartViewController.h"

@interface TableViewMainViewController ()

@end

@implementation TableViewMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"TableView相关学习";
}

-(void)jump:(UIViewController*) vc{
    //跳转到tableView
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)tableViewBase:(id)sender {
    [self jump:[[TableViewController alloc] init]];
}
- (IBAction)tableViewIndex:(id)sender {
    [self jump:[[TableViewIndexsController alloc] init]];
}
- (IBAction)tableViewCustomCell:(id)sender {
    [self jump:[[TableViewCustonCellViewController alloc] init]];
}
- (IBAction)tableViewDiffCell:(id)sender {
    [self jump:[[TableViewDiffCellViewController alloc] init]];
}
- (IBAction)shoppingCart:(id)sender {
    [self jump:[[ShoppingCartViewController alloc] init]];
}

@end
