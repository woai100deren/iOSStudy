//
//  AnimTransformViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimTransformViewController.h"

@interface AnimTransformViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AnimTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Transform形变";
}
- (IBAction)upMove:(id)sender {
    [self moveX:0 Y:-50];
}

- (IBAction)downMove:(id)sender {
    [self moveX:0 Y:50];
}
- (IBAction)rotate:(id)sender {
    //旋转角度，度数是个弧度，不是角度。M_PI_4 = 45度
    //使用Make时，是相对于当前控件最原始的左边进行移动。所以同一个方向点多次，第二次开始看到是无效的
//    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    //相当于上一次位置再进行操作
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_4);
}
- (IBAction)zoom:(id)sender {
    //旋转角度，度数是个弧度，不是角度。M_PI_4 = 45度
    //原始比例是1，比1大就是放大，比1小就是缩小
//    self.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    //相当于上一次位置再进行操作
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, 1.1, 1.1);
}

-(void)moveX:(CGFloat)x Y:(CGFloat)y{
    //使用Make时，是相对于当前控件最原始的左边进行移动。所以同一个方向点多次，第二次开始看到是无效的
//    self.imageView.transform = CGAffineTransformMakeTranslation(x, y);
    
    //相当于上一次移动到的位置进行移动
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, x, y);
}
@end
