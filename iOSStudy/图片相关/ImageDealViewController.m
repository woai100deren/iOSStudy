//
//  ImageDealViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageDealViewController.h"
#import "ImageWatermarkViewController.h"
#import "ImageTailorViewController.h"

@interface ImageDealViewController ()

@end

@implementation ImageDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片处理相关";
}
- (IBAction)imageAddWatermark:(id)sender {
    [self jump:[[ImageWatermarkViewController alloc] init]];
}
- (IBAction)imageTailor:(id)sender {
    [self jump:[[ImageTailorViewController alloc] init]];
}
-(void)jump:(UIViewController*)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
@end
