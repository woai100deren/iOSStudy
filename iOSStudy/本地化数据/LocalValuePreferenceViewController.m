//
//  LocalValuePreferenceViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValuePreferenceViewController.h"

@interface LocalValuePreferenceViewController ()

@end

@implementation LocalValuePreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Preference方式";
    
    [self saveData];
}

-(void)saveData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setURL:[NSURL URLWithString:@"https://www.baidu.com"] forKey:@"url"];
    [defaults setObject:@"这是一串字符串" forKey:@"object"];
    [defaults setBool:YES forKey:@"bool"];
    [defaults setFloat:10.6 forKey:@"float"];
    
    //立即写入到文件中
    [defaults synchronize];
    
    //读取
    NSLog(@"getUrl:%@",[defaults URLForKey:@"url"]);
    NSLog(@"getObject:%@",[defaults objectForKey:@"object"]);
    NSLog(@"getBool:%i",[defaults boolForKey:@"bool"]);
    NSLog(@"getFloat:%f",[defaults floatForKey:@"float"]);
}

@end
