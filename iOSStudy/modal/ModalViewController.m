//
//  ModalViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}
- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
