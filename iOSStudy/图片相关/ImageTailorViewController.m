//
//  ImageTailorViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ImageTailorViewController.h"
#import "Photos/Photos.h"

@interface ImageTailorViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end

@implementation ImageTailorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片裁剪";
    
    [self tailorImage1];
    [self tailorImage2];
}
/**
 不带边框的圆形裁剪
 */
-(void)tailorImage1{
    UIImage *image = [UIImage imageNamed:@"p4"];
    CGFloat minVlue = MIN(image.size.width, image.size.height);
    //手动开启跟原始图片大小的上下文
    //opaque:不透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(minVlue, minVlue), NO, 0);
    //设置一个圆形裁剪区域
    //绘制一个圆
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, minVlue, minVlue)];
    //把圆形设置为裁剪区域
    [path addClip];
    //把图片绘制到上下文中(要把图片绘制到正中间)
    CGPoint centerPoint = CGPointMake((minVlue - image.size.width)/2, (minVlue - image.size.height)/2);
    [image drawAtPoint:centerPoint];
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    self.imageView.image = newImage;
}

/**
 带边框的圆形裁剪
 */
-(void)tailorImage2{
    UIImage *image = [UIImage imageNamed:@"p4"];
    CGFloat minVlue = MIN(image.size.width, image.size.height);
    //边框宽度
    CGFloat borderWith = 10;
    //手动开启跟原始图片大小的上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(minVlue + borderWith *2, minVlue+ borderWith *2), NO, 0);
    //绘制一个大圆
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, minVlue + borderWith *2, minVlue + borderWith *2)];
    [[UIColor redColor] set];
    [bigCirclePath fill];
    //绘制一个小圆
    UIBezierPath *litleCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWith, borderWith, minVlue, minVlue)];
    //把小圆形设置为裁剪区域
    [litleCirclePath addClip];
    //把图片绘制到上下文中(要把图片绘制到正中间)
    CGPoint centerPoint = CGPointMake((minVlue - image.size.width)/2 + borderWith, (minVlue - image.size.height)/2 + borderWith);
    [image drawAtPoint:centerPoint];
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    self.imageView2.image = newImage;
}

-(void)screenShot{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //开启一个位图上下文（跟当前控制器view一样大小的尺寸）
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //获取context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控制器的view绘制到上下文中
    //想要把view的内容绘制到上下文中，必须得用渲染的方式
    [self.view.layer renderInContext:ctx];
    //从上下文中生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    self.imageView3.image = image;
    
    [self requestSaveImage:image];
    [self saveImageToFile:image];
}

-(void)requestSaveImage:(UIImage *)image{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status != PHAuthorizationStatusAuthorized) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片失败" message:@"请在设置-隐私-相册中允许当前应用访问相册" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                [self saveImageToDcim:image];
            }
        });
    }];
}
- (void)saveImageToDcim:(UIImage *)image{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
     } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",@"保存失败");
        } else {
            NSLog(@"%@",@"保存成功");
        }
    }];
}
/**
 存储到一个文件路径中
 */
-(void)saveImageToFile:(UIImage *)image{
    //把生成的图片写到一个路径中
    //把图片转换成二进制流
//    //jpeg格式
//    NSData *jpegData = UIImageJPEGRepresentation(image, 1);
//    [jpegData writeToURL:[NSURL fileURLWithPath:@"/Users/dodoca/Desktop/image.jpeg"] atomically:YES];
//
//    //png格式
//    NSData *pngData = UIImagePNGRepresentation(image);
//    [pngData writeToURL:[NSURL fileURLWithPath:@"/Users/dodoca/Desktop/image.png"] atomically:YES];
}
@end

