//
//  AnimViscousCustomButton.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/15.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimViscousCustomButton.h"

@interface AnimViscousCustomButton()
@property(weak,nonatomic)UIView *smallView;
@property(weak,nonatomic)CAShapeLayer *shapeLayer;
@end

@implementation AnimViscousCustomButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUp];
    //添加拖动手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGes];
}

- (CAShapeLayer *)shapeLayer{
    if(!_shapeLayer){
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [self.superview.layer insertSublayer:shapeLayer atIndex:0];
        shapeLayer.fillColor = UIColor.redColor.CGColor;
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

-(void)pan:(UIPanGestureRecognizer *)panGes{
    //拖动
    CGPoint point = [panGes translationInView:self];
    //transform并没有修改center，它修改的是frame
//    self.transform = CGAffineTransformTranslate(self.transform, point.x, point.y);
    CGPoint centerPoint = self.center;
    centerPoint.x += point.x;
    centerPoint.y += point.y;
    self.center = centerPoint;
    
    //复位
    [panGes setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self distanceWithSmallCircle:self.smallView BigCircle:self];
    //让小圆的半径随距离的增大而变小
    CGFloat smallCircleR = self.bounds.size.width * 0.5;
    smallCircleR -= distance / 10.0;
    self.smallView.bounds = CGRectMake(0, 0, smallCircleR * 2, smallCircleR * 2);
    self.smallView.layer.cornerRadius = smallCircleR;
    
    UIBezierPath *path = [self pathWithSmallCircle:self.smallView bitCircle:self];
    
    
    if(self.smallView.hidden == NO){
        //形状图层
        self.shapeLayer.path = path.CGPath;
    }
    if(distance > 200){
        //让小圆消失（隐藏），让路径隐藏
        self.smallView.hidden = YES;
        [self.shapeLayer removeFromSuperlayer];
    }
    
    if(panGes.state == UIGestureRecognizerStateEnded){
        if(distance < 200){
            [self.shapeLayer removeFromSuperlayer];
            self.center = self.smallView.center;
            self.smallView.hidden = NO;
        }else{
            //播放一个消失动画
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            imageView.backgroundColor = UIColor.whiteColor;
            NSMutableArray *imageArray = [NSMutableArray array];
            for(int i=1;i<=6;i++){
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"anim%d",i]];
                [imageArray addObject:image];
            }
            imageView.animationImages = imageArray;
            imageView.animationDuration = 1;
            [imageView startAnimating];
            [self addSubview:imageView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
        }
        
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    //圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    //设置背景颜色
    self.backgroundColor = UIColor.redColor;
    [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    //添加小圆
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.layer.cornerRadius = self.layer.cornerRadius;
    view.backgroundColor = UIColor.redColor;
    [self.superview addSubview:view];
    self.smallView = view;
    
    //把一个view添加到指定的位置
    [self.superview insertSubview:view belowSubview:self];
}

-(CGFloat)distanceWithSmallCircle:(UIView *)smallView BigCircle:(UIView *)bigView{
    //x轴的偏移量
    CGFloat offsetX = bigView.center.x - smallView.center.x;
    //y轴的偏移量
    CGFloat offsetY = bigView.center.y - smallView.center.y;
    
    //开平方
    return sqrtf(offsetX * offsetX + offsetY * offsetY);
}

-(void)setHighlighted:(BOOL)highlighted{
    //取消高亮状态
}

-(UIBezierPath *)pathWithSmallCircle:(UIView *)smallView bitCircle:(UIView *)bigView{
    CGFloat x1 = smallView.center.x;
    CGFloat y1 = smallView.center.y;
    
    CGFloat x2 = bigView.center.x;
    CGFloat y2 = bigView.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallView BigCircle:bigView];
    
    if(d<=0){
        return  nil;
    }
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallView.bounds.size.width * 0.5;
    CGFloat r2 = bigView.bounds.size.width * 0.5;
    
    //描述点
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 *sinθ, pointA.y +d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 *sinθ, pointB.y +d * 0.5 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //A-B
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //C-D
    [path addLineToPoint:pointD];
    //DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    return path;
}
@end
