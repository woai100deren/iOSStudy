//
//  GestureLockViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "GestureLockViewController.h"
#import "GestureLockView.h"

@interface GestureLockViewController ()
@property (weak, nonatomic) IBOutlet GestureLockView *gestureView;

@end

@implementation GestureLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手势解锁";
}
- (IBAction)clearPwd:(id)sender {
    [self.gestureView clearPwd];
}

@end
