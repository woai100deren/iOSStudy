//
//  FirstViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DeliverValueFirstViewController.h"
#import "DeliverValueSecondViewController.h"

@interface DeliverValueFirstViewController ()<DeliverValueSecondViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DeliverValueFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第一个页面";
}

//实现协议中的方法
- (void)deliverValue:(NSString *)value{
    self.label.text = [NSString stringWithFormat:@"第二个页面传递过来的值是：%@",value];
}

- (IBAction)jumpSecond:(id)sender {
    DeliverValueSecondViewController *vc = [[DeliverValueSecondViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
