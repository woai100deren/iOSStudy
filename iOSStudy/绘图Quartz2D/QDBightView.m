//
//  QDBightView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDBightView.h"

@implementation QDBightView


- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 280)];
    //添加一根曲线，到哪个点，控制点是哪里(控制点就是曲线的弯曲方向朝那个点)
    [path addQuadCurveToPoint:CGPointMake(280, 280) controlPoint:CGPointMake(50, 50)];
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextStrokePath(ctx);
}

@end
