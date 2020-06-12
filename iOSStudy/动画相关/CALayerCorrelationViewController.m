//
//  CALayerCorrelationViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/12.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "CALayerCorrelationViewController.h"

@interface CALayerCorrelationViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation CALayerCorrelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CALayer相关";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self uiViewCALayerChanged];
    [self imageViewCALayerChanged];
    [self caTransform3D];
}
/**
 UIView的CALayer相关值设置
 */
-(void)uiViewCALayerChanged{
    CALayer *layer = self.redView.layer;
    //阴影颜色
    layer.shadowColor = UIColor.blueColor.CGColor;
    //阴影的不透明度，0是透明，1是不透明
    layer.shadowOpacity = 1;
    //设置阴影偏移量
    layer.shadowOffset = CGSizeMake(10, 10);
    //设置阴影模糊半径
    layer.shadowRadius = 5;
    
    //边框宽度（边框宽度是在原始view的宽高不变情况下，往view里面填充扩展）
    layer.borderWidth = 5;
    //边框颜色
    layer.borderColor = UIColor.greenColor.CGColor;
    
    //圆角
    layer.cornerRadius = 30;
}
/**
 UIImageView的CALayer相关值设置
 */
-(void)imageViewCALayerChanged{
    CALayer *layer = self.imageView.layer;
    //阴影颜色
    layer.shadowColor = UIColor.blueColor.CGColor;
    //阴影的不透明度，0是透明，1是不透明
    layer.shadowOpacity = 1;
    //设置阴影偏移量
    layer.shadowOffset = CGSizeMake(30, 30);
    //设置阴影模糊半径
    layer.shadowRadius = 5;
    
    //把超过根层以外的东西自动裁剪掉（UIView自带的层，称为根层）
    //如果这个值设置为NO，有阴影效果，但是下面的圆角效果无效
    //如果这个值设置为YES，则无阴影效果，但是下面的圆角效果有效
    layer.masksToBounds = YES;
    
    //边框宽度（边框宽度是在原始view的宽高不变情况下，往view里面填充扩展）
    layer.borderWidth = 2;
    //边框颜色
    layer.borderColor = UIColor.greenColor.CGColor;
    
    //圆角
    layer.cornerRadius = 100;
}
/**
 UIView的CATransform3D相关值设置
 */
-(void)caTransform3D{
    [UIView animateWithDuration:0.5 animations:^{
        //旋转效果(绕哪个轴旋转，哪个轴就写1)
        self.imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        //旋转效果(绕哪个轴旋转，哪个轴就写1)
        self.redView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        //旋转效果(绕哪个轴旋转，哪个轴就写1)
//        self.imageView2.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        //也可以这么写
        //把结构体转对象
        NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
        //通过KVC一般是做快速旋转、平移、缩放
        [self.imageView2.layer setValue:value forKeyPath:@"transform"];
//        //旋转180度，forkey可以查看文档的 CATransform3D Key Paths
//        [self.imageView2.layer setValue:@(M_PI) forKeyPath:@"transform.rotation"];
//        //x轴旋转180度
//        [self.imageView2.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.x"];
//        //x轴旋转180度
//        [self.imageView2.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.y"];
//        //缩放0.5
//        [self.imageView2.layer setValue:@(0.5) forKeyPath:@"transform.scale"];
//        //X轴平移100
//        [self.imageView2.layer setValue:@(100) forKeyPath:@"transform.translation.x"];
    }];
    
}
@end
