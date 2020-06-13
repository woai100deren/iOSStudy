//
//  ImageFoldViewController.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/13.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageFoldViewController.h"

@interface ImageFoldViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (weak, nonatomic) IBOutlet UIView *clearView;

@property (weak,nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation ImageFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片折叠";
    
    //上图片显示上半部分，下图片显示下部分
    self.upImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.downImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    
    self.upImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.downImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    [self addGradientLayer];
}

-(void)addGradientLayer{
    //渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.downImageView.bounds;
    gradientLayer.colors = @[(id)UIColor.clearColor.CGColor,(id)UIColor.blackColor.CGColor];
//    //设置渐变的方向
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//    //设置一个渐变到另外一个渐变的起始位置
//    gradientLayer.locations = @[@0.2,@0.6];
    
    //开始时，渐变为透明.不透明度
    gradientLayer.opacity = 0;
    [self.downImageView.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
}

- (IBAction)clearViewPan:(UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:pan.view];
    CGFloat angle =  transP.y *M_PI / 200;
    
    //近大远小的效果
    CATransform3D transform = CATransform3DIdentity;
    //眼睛离屏幕的距离
    transform.m34 = -1 /300.0;
    
    self.gradientLayer.opacity = transP.y / 200.0;
    
    //让上图旋转
//    self.upImageView.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);
    self.upImageView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    
    if(pan.state == UIGestureRecognizerStateEnded){
        self.gradientLayer.opacity = NO;
        //usingSpringWithDamping 弹性系数，越小弹性越大
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            //复位
            self.upImageView.layer.transform = CATransform3DIdentity;
        } completion:nil];
        
    }
}

@end
