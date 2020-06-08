//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property(nonatomic,weak) IBOutlet UILabel *colorLabel;

@end

@implementation SecondViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self addTextField];
    [self addImageView];
    [self addButton];
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

#pragma mark - 设置UI布局
- (void)addTextField{
    UITextField *uiTextField = [[UITextField alloc] init];
    //占位文字
    uiTextField.placeholder = @"这是一个输入框";
    //设置占位文字的颜色
    NSDictionary *attrDict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:uiTextField.placeholder attributes:attrDict];
    [uiTextField setAttributedPlaceholder:attrStr];
    //设置边框宽度
    uiTextField.layer.borderWidth = 1;
    //设置控件圆角
    uiTextField.layer.cornerRadius = 5.0;
    //背景颜色
    uiTextField.backgroundColor = UIColor.lightGrayColor;
    //弹出键盘类型
    uiTextField.keyboardType = UIKeyboardTypeNumberPad;
    //设置空间的位置和高宽
    uiTextField.frame = CGRectMake(100, 100, 200, 40);
    //文字对齐方式
    uiTextField.textAlignment = NSTextAlignmentCenter;
    //文字大小
    uiTextField.font = [UIFont systemFontOfSize:16.0f];
    //设置文字颜色
    uiTextField.textColor = UIColor.whiteColor;
    [self.view addSubview:uiTextField];
}

- (void)addImageView{
    UIImageView *uiImageView = [[UIImageView alloc] init];
    //设置空间的位置和高宽
    uiImageView.frame = CGRectMake(100, 150, 200, 200);
    [self.view addSubview:uiImageView];
    
    //背景颜色
    uiImageView.backgroundColor = UIColor.lightGrayColor;
    //设置图片，png图片不用加.png的后缀
    uiImageView.image = [UIImage imageNamed:@"katong"];
    //图片显示的裁剪方式
    uiImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //毛玻璃
    UIToolbar *uiToolBar = [[UIToolbar alloc] init];
    uiToolBar.frame = uiImageView.bounds;
    //设置毛玻璃的样式
    uiToolBar.barStyle = UIBarStyleBlack;
    //毛玻璃透明度
    uiToolBar.alpha = 0.9;
    //把毛玻璃添加到图片控件中
    [uiImageView addSubview:uiToolBar];
}

- (void)addButton{
    UIButton *uiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置空间的位置和高宽
    uiButton.frame = CGRectMake(100, 400, 200, 50);
    //背景颜色
    uiButton.backgroundColor = UIColor.lightGrayColor;
    [uiButton setTitle:@"这是一个按钮" forState:UIControlStateNormal];
    [uiButton setTitle:@"我被点击了" forState:UIControlStateHighlighted];
    [self.view addSubview:uiButton];
    
    //给按钮添加点击事件
    [uiButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClick:(UIButton *) sender{
    NSLog(@"跳转到下一个页面");
}
@end
