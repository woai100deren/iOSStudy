//
//  ImageInvertedViewController.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/14.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageInvertedViewController.h"

@interface ImageInvertedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *normalImageView;

@end

@implementation ImageInvertedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片倒影";
    
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.view.layer;
    layer.instanceCount = 2;
    //绕着复制层锚点进行旋转
    layer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    //阴影
    layer.instanceRedOffset -=0.1;
    layer.instanceGreenOffset -=0.1;
    layer.instanceBlueOffset -=0.1;
    layer.instanceAlphaOffset -=0.1;
}
@end
