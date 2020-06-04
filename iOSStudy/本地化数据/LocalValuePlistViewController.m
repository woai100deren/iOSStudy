//
//  LocalValuePlistViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValuePlistViewController.h"

@interface LocalValuePlistViewController ()

@end

@implementation LocalValuePlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Plist方式";
    
    [self getDocumentsPath];
}

-(void)getDocumentsPath{
    NSLog(@"%@", NSHomeDirectory());
}
@end
