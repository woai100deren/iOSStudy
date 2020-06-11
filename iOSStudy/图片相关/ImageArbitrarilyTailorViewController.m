//
//  ImageArbitrarilyTailorViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageArbitrarilyTailorViewController.h"

@interface ImageArbitrarilyTailorViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign,nonatomic)CGPoint startPoint;
@property (weak,nonatomic)UIView *cover;
@end

@implementation ImageArbitrarilyTailorViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片任何裁剪";
    
    self.imageView.userInteractionEnabled = YES;
}

- (UIView *)cover{
    if(_cover == nil){
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = UIColor.whiteColor;
        cover.alpha = 0.7;
        _cover = cover;
        [self.imageView addSubview:cover];
    }
    return _cover;
}

- (IBAction)imageViewPanGes:(UIPanGestureRecognizer *)panGes {
    CGPoint currentPoint = [panGes locationInView:self.imageView];
    if(panGes.state == UIGestureRecognizerStateBegan){
        self.startPoint = currentPoint;
    }else if(panGes.state == UIGestureRecognizerStateChanged){
        CGFloat x = self.startPoint.x;
        CGFloat y = self.startPoint.y;
        CGFloat with = currentPoint.x - x;
        CGFloat height = currentPoint.y - y;
        
        self.cover.frame = CGRectMake(x, y, with, height);
    }else if(panGes.state == UIGestureRecognizerStateEnded){
        //把超过cover的裁剪掉
        //手动开启跟原始图片大小的上下文
        //opaque:不透明
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
        //绘制一个裁剪区域
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.cover.frame];
        //把圆形设置为裁剪区域
        [path addClip];
        //移除遮盖(要先移除，否则，裁剪出来的图片会带遮罩)
        [self.cover removeFromSuperview];
        //把图片绘制到上下文中
        [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        //从上下文中取出图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        
        self.imageView.image = newImage;
    }
}
@end
