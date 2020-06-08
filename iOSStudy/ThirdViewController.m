//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThirdViewController.h"
#import "CarView.h"
#import "Car.h"
#import "NewCarView.h"
#import "UIColor+Hex.h"

@interface ThirdViewController ()

@property(nonatomic,weak) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ThirdViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    Car *car = [[Car alloc] init];
    car.image = @"car";
    car.title = @"我TM是真的帅气";
    car.subTitle = @"我是一个小气的副标题我是一个小气的副标题我是一个小气的副标题我是一个小气的副标题我是一个小气的副标题";
    
    //以下是xib自定义控件
//    CarView *carView = [CarView carView];
//    [self.view addSubview:carView];
//    carView.frame = CGRectMake(0, 100, 414, 84);
//    carView.car = car;
    
    //以下是继承UIView的传统自定义控件
    NewCarView *newCarView = [[NewCarView alloc] init];
    [self.view addSubview:newCarView];
    newCarView.frame = CGRectMake(0, 100, 414, 84);
    newCarView.backgroundColor = UIColor.grayColor;
    newCarView.car = car;
    
    //设置按钮内边距
    self.imageButton.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    //设置图片的内边距
    self.imageButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    //设置标题的内边距
    self.imageButton.titleEdgeInsets =UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIImage *image = [UIImage imageNamed:@"chat_bg"];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    //类似于android的.9图片处理
    //方式一：下面的代码是给chat_bg正中间留一像素进行拉伸。
//    UIImage *resizeableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHeight * 0.5, imageWidth * 0.5, imageHeight * 0.5 - 1, imageWidth * 0.5 - 1) resizingMode:UIImageResizingModeTile];
    
    //方式二
//    右边要保护的区域 = 图片的width - leftCapWidth - 1
//    底部要保护的区域 = 图片的heigt - topCapHeight - 1
    UIImage *resizeableImage = [image stretchableImageWithLeftCapWidth:imageWidth * 0.5 topCapHeight:imageHeight * 0.5];
    [self.button setBackgroundImage:resizeableImage forState:UIControlStateNormal];
    
    //方式三，直接在assets里面，选中图片，slices选中水平和垂直，直接设置要保护的区域即可
//    [self.button setBackgroundImage:image forState:UIControlStateNormal];
}

#pragma mark - 点击红色按钮
- (IBAction)clickRedButton{
    [self setLabelColor:UIColor.redColor];
    NSLog(@"点击了%s",__func__);
}

#pragma mark - 点击绿色按钮
- (IBAction)clickGreenButton{
    [self setLabelColor:UIColor.greenColor];
    NSLog(@"点击了%s",__func__);
}

#pragma mark - 点击蓝色按钮
- (IBAction)clickBlueButton{
    [self setLabelColor:UIColor.blueColor];
    NSLog(@"点击了%s",__func__);
}

- (void)setLabelColor:(UIColor*) uiColor{
    self.colorLabel.textColor =uiColor;
}
@end
