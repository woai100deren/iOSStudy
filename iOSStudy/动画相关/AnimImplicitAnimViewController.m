//
//  ImplicitAnimViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/12.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimImplicitAnimViewController.h"

@interface AnimImplicitAnimViewController ()
@property(weak,nonatomic)CALayer *layer;
@property(weak,nonatomic)UIView *redView;
@end

@implementation AnimImplicitAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐式动画";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(250, 50, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    self.redView = view;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.backgroundColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //手动创建的layer自带动画
    [CATransaction begin];
    //关闭自带动画（设置为YES）
    [CATransaction setDisableActions:NO];
    //设置动画执行时间为2秒
    [CATransaction setAnimationDuration:2];
    self.layer.position = CGPointMake(100, 400);
    //在提交之前的，会按照动画执行，之后的，立即执行
    [CATransaction commit];
    self.layer.backgroundColor = UIColor.blueColor.CGColor;
    
    //控件自带的layer默认没有动画
    self.redView.layer.position = CGPointMake(300, 400);
    self.redView.layer.backgroundColor = UIColor.blueColor.CGColor;
}

@end
