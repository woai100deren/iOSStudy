//
//  AnimParticleEffectView.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/14.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimParticleEffectView.h"

@interface AnimParticleEffectView()
@property (strong,nonatomic) UIBezierPath *path;
@property (strong,nonatomic) CALayer *dotlayer;
@end

@implementation AnimParticleEffectView
+(Class)layerClass{
    return [CAReplicatorLayer class];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGes];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    
    //添加粒子
    CALayer *dotlayer = [CALayer layer];
    dotlayer.frame = CGRectMake(-20, 0, 20, 20);
    dotlayer.backgroundColor = UIColor.redColor.CGColor;
    [self.layer addSublayer:dotlayer];
    self.dotlayer = dotlayer;
    
    CAReplicatorLayer *repl = (CAReplicatorLayer *)self.layer;
    repl.instanceCount = 30;
    repl.instanceDelay = 0.5;
}

- (void)drawRect:(CGRect)rect{
    [self.path stroke];
}

-(void)pan:(UIGestureRecognizer *)ges{
    CGPoint currentPoint = [ges locationInView:self];
    if(ges.state == UIGestureRecognizerStateBegan){
        [self.path moveToPoint:currentPoint];
    }else if(ges.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
}

- (void)start{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 5;

    [self.dotlayer addAnimation:anim forKey:nil];
}
- (void)redraw{
    //删除动画
    [self.dotlayer removeAllAnimations];
    //删除路径
    [self.path removeAllPoints];
    //重绘
    [self setNeedsDisplay];
}
@end
