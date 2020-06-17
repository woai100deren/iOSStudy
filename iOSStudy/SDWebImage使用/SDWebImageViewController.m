//
//  SDWebImageViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SDWebImageViewController.h"
#import "SDWebImageListViewController.h"
#import "SDWebImageFrameViewController.h"

@interface SDWebImageViewController ()

@end

@implementation SDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SDWebImage的使用";
}
- (IBAction)imageList:(id)sender {
    [self jump:[[SDWebImageListViewController alloc] init]];
}
- (IBAction)use:(id)sender {
    [self jump:[[SDWebImageFrameViewController alloc] init]];
}
-(void)jump:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
