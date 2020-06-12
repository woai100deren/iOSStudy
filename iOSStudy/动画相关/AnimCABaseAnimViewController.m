//
//  AnimCABaseAnimViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/12.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimCABaseAnimViewController.h"

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)

@interface AnimCABaseAnimViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *dogImage;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIImageView *transitionsImage;

@end

@implementation AnimCABaseAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Core Animation基础核心动画";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setUIViewAnim];
    [self setUIImageViewAnim];
    [self setUIImageViewShake];
    [self setUIViewMove];
    [self setTransitionsImage];
}

-(void)setUIViewAnim{
    //CAAnimation动画完成时，会自动删除动画，不处理的话，动画完成之后，控件会还原
    //创建动画对象(设置layer的属性值)
    CABasicAnimation *anim = [CABasicAnimation animation];
    //将redview的layer的position的x值变为300
    anim.keyPath = @"position.x";
    anim.toValue = @300;
    //让动画完成后，不自动删除动画，保持layer的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:anim forKey:nil];
}

-(void)setUIImageViewAnim{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    //@符号不能忘记写
    anim.toValue = @0;
    //动画时长
    anim.duration = 1;
    //自动反转
    anim.autoreverses = YES;
    //动画执行次数
    anim.repeatCount = MAXFLOAT;
    [self.imageView.layer addAnimation:anim forKey:nil];
}

-(void)setUIImageViewShake{
    //创建动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //旋转
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Rad(-5)),@(angle2Rad(5)),@(angle2Rad(-5))];
    //动画执行次数
    anim.repeatCount = MAXFLOAT;
    //动画时长
    anim.duration = 0.5;
    
    [self.dogImage.layer addAnimation:anim forKey:nil];
}

-(void)setUIViewMove{
    //创建动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //动画时长
    anim.duration = 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 500)];
    [path addLineToPoint:CGPointMake(300, 500)];
    [path addLineToPoint:CGPointMake(300, 700)];
    
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    
    [self.blueView.layer addAnimation:anim forKey:nil];
}

static int i = 1;
-(void)setTransitionsImage{
    //转场代码和转场动画的代码，要放到一个方法中，否则无效。代码顺序可以随便写
    
    NSString *imageName;
    if(i == 1){
        imageName = @"drink7";
        i = 2;
    }else{
        imageName = @"drink8";
        i = 1;
    }
    self.transitionsImage.image = [UIImage imageNamed:imageName];
    
    CATransition *anim = [CATransition animation];
    anim.duration = 0.5;
    //设置转场类型
    //cube 立方体翻滚效果
    //rippleEffect 水滴效果
    anim.type = @"pageCurl";
    
    //设置动画的起始位置
    //值0~1，默认0
    anim.startProgress = 0;
    anim.endProgress = 0.8;
    
    [self.transitionsImage.layer addAnimation:anim forKey:nil];
}
@end
