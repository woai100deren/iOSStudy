//
//  AnimationMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimationMainViewController.h"
#import "AnimTransformViewController.h"

@interface AnimationMainViewController ()

@end

@implementation AnimationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动画相关";
}

- (IBAction)jumpTransform:(id)sender {
    [self jump:[[AnimTransformViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    [self.navigationController pushViewController:vc animated:YES];
}
@end
