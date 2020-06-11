//
//  DrawingBoardViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DrawingBoardViewController.h"
#import "DrawingBoardView.h"
#import "Photos/Photos.h"

@interface DrawingBoardViewController ()
@property (weak, nonatomic) IBOutlet DrawingBoardView *drawBoard;

@end

@implementation DrawingBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"画板";
}

- (void)saveImage{
    //开启一个位图上下文（跟当前控制器view一样大小的尺寸）
    UIGraphicsBeginImageContextWithOptions(self.drawBoard.bounds.size, NO, 0);
    //获取context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控制器的view绘制到上下文中
    //想要把view的内容绘制到上下文中，必须得用渲染的方式
    [self.drawBoard.layer renderInContext:ctx];
    //从上下文中生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    [self requestSaveImage:image];
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
        NSString *message;
        if (error) {
            message = @"保存失败";
        } else {
           message = @"保存成功";
        }
        
         dispatch_async(dispatch_get_global_queue(0,0), ^{
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:okAction];
             [self presentViewController:alertController animated:YES completion:nil];
         });
    }];
}


#pragma mark -actions
/**
 清屏
 */
- (IBAction)clearAll:(id)sender {
    [self.drawBoard clearAll];
}
/**
 撤销
 */
- (IBAction)repeal:(id)sender {
    [self.drawBoard repeal];
}
/**
 橡皮擦
 */
- (IBAction)eraser:(id)sender {
    [self.drawBoard eraser];
}
/**
 选择相片
 */
- (IBAction)selectPhoto:(id)sender {
}
/**
 保存图片
 */
- (IBAction)saveImage:(id)sender {
    [self saveImage];
}
/**
 选中黄色
 */
- (IBAction)yellowColor:(id)sender {
    self.drawBoard.penColor = UIColor.yellowColor;
}
/**
 选中红色
 */
- (IBAction)redColor:(id)sender {
    self.drawBoard.penColor = UIColor.redColor;
}
/**
 选中蓝色
 */
- (IBAction)blueColor:(id)sender {
    self.drawBoard.penColor = UIColor.blueColor;
}
/**
 slider值变化
 */
- (IBAction)sliderValueChanged:(UISlider*)slider {
    self.drawBoard.penStroke = slider.value * 50;
}
@end
