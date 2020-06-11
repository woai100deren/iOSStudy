//
//  ImgeWipeViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImgeWipeViewController.h"

@interface ImgeWipeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation ImgeWipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片擦除";
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.coverImageView addGestureRecognizer:panGes];
    self.coverImageView.userInteractionEnabled = YES;
}

-(void)panGes:(UIPanGestureRecognizer *)panGes{
    CGFloat rectWith = 50;
    CGPoint currentPoint = [panGes locationInView:self.coverImageView];
    //确定擦除区域
    CGRect rect = CGRectMake(currentPoint.x - rectWith/2, currentPoint.y -rectWith/2, rectWith, rectWith);
    //生成一个透明的擦除区域
    //手动开启跟原始图片大小的上下文
    //opaque:不透明
    UIGraphicsBeginImageContextWithOptions(self.coverImageView.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把图片绘制到上下文中
    [self.coverImageView.layer renderInContext:ctx];
    //擦除上下文中指定的区域
    CGContextClearRect(ctx, rect);
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    self.coverImageView.image = newImage;
}
@end

