//
//  AnimVolumeVibrateViewController.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/14.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimVolumeVibrateViewController.h"

@interface AnimVolumeVibrateViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AnimVolumeVibrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"音量震动";
    
    //复制层
    CAReplicatorLayer *repl = [CAReplicatorLayer layer];
    repl.backgroundColor = UIColor.lightGrayColor.CGColor;
    repl.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:repl];
    //复制的份数（包括它自己）
    repl.instanceCount = 5;
    //对复制出来的子层做形变操作(每一个都是相对于上一个子层做的形变)
    repl.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    //设置复制出来的子层动画延迟执行时长
    repl.instanceDelay = 0.5;
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = UIColor.redColor.CGColor;
    layer.frame = CGRectMake(0, 0, 30, 100);
    layer.position = CGPointMake(0, self.contentView.bounds.size.height);
    layer.anchorPoint = CGPointMake(0, 1);
    [repl addSublayer:layer];
    
    //添加动画
    CABasicAnimation *anim =  [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.5;
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
}

@end
