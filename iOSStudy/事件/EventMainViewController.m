//
//  EventMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "EventMainViewController.h"
#import "EventUIDragViewController.h"
#import "EventTransmitViewController.h"
#import "GestureViewController.h"
#import "ImageFoldViewController.h"

@interface EventMainViewController ()

@end

@implementation EventMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Event事件";
}
- (IBAction)uiDrag:(id)sender {
    [self jump:[[EventUIDragViewController alloc] init]];
}
- (IBAction)eventTransmit:(id)sender {
    [self jump:[[EventTransmitViewController alloc] init]];
}
- (IBAction)jumpGesture:(id)sender {
    [self jump:[[GestureViewController alloc] init]];
}
- (IBAction)imageFold:(id)sender {
    [self jump:[[ImageFoldViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    [self.navigationController pushViewController:vc animated:YES];
}
@end
