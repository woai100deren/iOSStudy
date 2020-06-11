//
//  ImageWatermarkViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageWatermarkViewController.h"

@interface ImageWatermarkViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageWatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片加水印";
    
    UIImage *image = [UIImage imageNamed:@"p4"];
    //手动开启跟原始图片大小的上下文
    //opaque:不透明
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //把图片绘制到上下文中
    [image drawAtPoint:CGPointZero];
    //把文字绘制到上下文中
    NSString *waterString = @"我是水印";
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    //字体大小
    attrDic[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    //字体颜色
    attrDic[NSForegroundColorAttributeName] = [UIColor redColor];
    [waterString drawAtPoint:CGPointMake(10,10) withAttributes:attrDic];
    //从上下文中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;
}

@end
