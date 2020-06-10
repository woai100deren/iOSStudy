//
//  DrawerViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController ()
@property(weak,nonatomic)UIView *mainView;
@property(weak,nonatomic)UIView *leftView;
@property(weak,nonatomic)UIView *rightView;
@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"抽屉效果";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpViews];
}

-(void)setUpViews{
    //左view
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = UIColor.blueColor;
    self.leftView = leftView;
    [self.view addSubview:leftView];
    //右view
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor = UIColor.greenColor;
    self.rightView = rightView;
    [self.view addSubview:rightView];
    //主view
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = UIColor.redColor;
    self.mainView = mainView;
    [self.view addSubview:mainView];
    
    //添加手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:panGes];
    
    //给控制器添加点按手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [self.view addGestureRecognizer:tapGes];
}

-(void)tapGes{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
    
}

#define targetR 275
#define targetL -275
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
-(void)pan:(UIPanGestureRecognizer*)panGes{
    //获取偏移量
    CGPoint point = [panGes translationInView:self.mainView];
    //不能使用transform，因为还要修改高度。transform只能修改X、Y
//    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, point.x, 0);
    
    self.mainView.frame = [self frameWithOffset:point.x];
    //判断拖动的方向
    if(self.mainView.frame.origin.x > 0){
        //向右
        self.rightView.hidden = YES;
        self.leftView.hidden = NO;
    }else if(self.mainView.frame.origin.x < 0){
        //向左
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    }
    //当手指松开时，自动定位
    CGFloat target = 0;
    if(panGes.state == UIGestureRecognizerStateEnded){
        if(self.mainView.frame.origin.x > screenW/2){
            //判断在右侧
            target = targetR;
            
        }else if(CGRectGetMaxX(self.mainView.frame) < screenW/2){
            //判断在左侧
            target = targetL;
        }
        //计算mainview的frame
        CGFloat offset = target - self.mainView.frame.origin.x;
        //加一个动画
        [UIView animateWithDuration:0.5 animations:^{
            self.mainView.frame = [self frameWithOffset:offset];
        }];
    }
    
    //让他相对上一次(清零)
    [panGes setTranslation:CGPointZero inView:self.mainView];
    
}

#define maxY 100
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define navHeight self.navigationController.navigationBar.bounds.size.height
//根据偏移量计算mainview的frame
-(CGRect)frameWithOffset:(CGFloat)offsetx{
    CGRect frame = self.mainView.frame;
    frame.origin.x += offsetx;
    
    //计算Y轴,fabs取绝对值
    frame.origin.y = fabs(frame.origin.x * maxY / screenW);
    //计算高度：屏幕高度 - 状态栏高度 - 导航栏高度 - Y轴偏移量2倍
    frame.size.height = screenH -statusBarHeight - navHeight - (2 * frame.origin.y);
    
    return frame;
}
@end
