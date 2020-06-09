//
//  GestureViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet UILabel *longClickLabel;
@property (weak, nonatomic) IBOutlet UILabel *swipeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *scaleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rotateAndScaleImageView;

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点按
    UITapGestureRecognizer *clickGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    clickGes.delegate = self;
    //开启可交互设置
    self.clickLabel.userInteractionEnabled = YES;
    [self.clickLabel addGestureRecognizer:clickGes];
    
    //长按
    UILongPressGestureRecognizer *longClickGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
    //开启可交互设置
    self.longClickLabel.userInteractionEnabled = YES;
    [self.longClickLabel addGestureRecognizer:longClickGes];
    
    //轻扫
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    //轻扫手势的方向，不设置会无效，一个手势只能设置一个方向
    swipeGes.direction = UISwipeGestureRecognizerDirectionRight;
    //开启可交互设置
    self.swipeLabel.userInteractionEnabled = YES;
    [self.swipeLabel addGestureRecognizer:swipeGes];
    
    //拖动
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //开启可交互设置
    self.moveLabel.userInteractionEnabled = YES;
    [self.moveLabel addGestureRecognizer:panGes];
    
    //旋转
    UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    //开启可交互设置
    self.rotateImageView.userInteractionEnabled = YES;
    [self.rotateImageView addGestureRecognizer:rotateGes];
    
    //啮合手势（缩放）
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    //开启可交互设置
    self.scaleImageView.userInteractionEnabled = YES;
    [self.scaleImageView addGestureRecognizer:pinchGes];
    
    
    
    //旋转
    UIRotationGestureRecognizer *rotateGes2 = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate2:)];
    rotateGes2.delegate = self;
    //啮合手势（缩放）
    UIPinchGestureRecognizer *pinchGes2 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch2:)];
    pinchGes2.delegate = self;
    //开启可交互设置
    self.rotateAndScaleImageView.userInteractionEnabled = YES;
    [self.rotateAndScaleImageView addGestureRecognizer:rotateGes2];
    [self.rotateAndScaleImageView addGestureRecognizer:pinchGes2];
}

-(void)click{
    self.messageLabel.text = @"单击";
}

//当长按移动时，会持续调用
-(void)longClick:(UILongPressGestureRecognizer*)gesture{
    //判断手势状态
    if(gesture.state == UIGestureRecognizerStateBegan){
        self.messageLabel.text = @"长按";
    }
}

-(void)swipe{
    self.messageLabel.text = @"轻扫";
}

//拖动
-(void)pan:(UIPanGestureRecognizer *)panGes{
    //获取偏移量(相对最原始的偏移量)
    CGPoint point = [panGes translationInView:self.moveLabel];
    self.moveLabel.transform = CGAffineTransformTranslate(self.moveLabel.transform, point.x, point.y);
    //让他相对上一次(清零)
    [panGes setTranslation:CGPointZero inView:self.moveLabel];
}

-(void)rotate:(UIRotationGestureRecognizer*)rotateGes{
    self.rotateImageView.transform = CGAffineTransformRotate(self.rotateImageView.transform, rotateGes.rotation);
    //每次复位
    [rotateGes setRotation:0];
}

-(void)pinch:(UIPinchGestureRecognizer*)pinchGes{
    self.scaleImageView.transform = CGAffineTransformScale(self.scaleImageView.transform, pinchGes.scale, pinchGes.scale);
    //每次要复位
    [pinchGes setScale:1];
}


-(void)rotate2:(UIRotationGestureRecognizer*)rotateGes{
    self.rotateAndScaleImageView.transform = CGAffineTransformRotate(self.rotateAndScaleImageView.transform, rotateGes.rotation);
    //每次复位
    [rotateGes setRotation:0];
}

-(void)pinch2:(UIPinchGestureRecognizer*)pinchGes{
    self.rotateAndScaleImageView.transform = CGAffineTransformScale(self.rotateAndScaleImageView.transform, pinchGes.scale, pinchGes.scale);
    //每次要复位
    [pinchGes setScale:1];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //是否允许接收手势
    return YES;
}

//是否允许多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end
