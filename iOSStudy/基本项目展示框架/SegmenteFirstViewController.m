//
//  SegmenteFirstViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SegmenteFirstViewController.h"

@interface SegmenteFirstViewController ()

@end

@implementation SegmenteFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 20);
    label.text = @"第一个";
    [self.view addSubview:label];
}


@end
