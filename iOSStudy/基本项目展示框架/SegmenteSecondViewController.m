//
//  SegmenteSecondViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SegmenteSecondViewController.h"

@interface SegmenteSecondViewController ()

@end

@implementation SegmenteSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 20);
    label.text = @"第二个";
    [self.view addSubview:label];
}
@end
