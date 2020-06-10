//
//  QDShapeView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDShapeView.h"

@implementation QDShapeView


- (void)drawRect:(CGRect)rect {
    [self drawRectangle];
    [self drawCircle];
    [self drawArc];
    [self drawPie];
}

/**
 画矩形
 */
-(void)drawRectangle{
    //方法一、使用context方式绘制
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //实心矩形
    UIBezierPath *solidRectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(5, 5, 50, 25)];
    //空心矩形
    UIBezierPath *hollowRectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(60, 5, 50, 25)];
    //圆角矩形
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(115, 5, 50, 25) cornerRadius:5];
    
    CGContextAddPath(ctx, solidRectanglePath.CGPath);
    CGContextFillPath(ctx);
    
    CGContextAddPath(ctx, hollowRectanglePath.CGPath);
    CGContextAddPath(ctx, roundedRectanglePath.CGPath);
    CGContextStrokePath(ctx);
}

/**
 画圆形、椭圆
 */
-(void)drawCircle{
    //方法二、不使用context方式，使用path自带的方式绘制
    //椭圆
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 35, 50, 25)];
    //path stroke：底层实际上操作：1、获取上下文  2、描述路径   3、把路径添加到上下文   4、渲染
    [circlePath stroke];
    
    //圆
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 35, 25, 25)] stroke];
}

/**
 画弧
 */
-(void)drawArc{
    //弧1：Center：弧所在的圆心，radius半径，startAngle开始角度，endAngle结束角度，clockwise顺时针(YES)还是逆时针(NO)
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(115, 60) radius:25 startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    //关闭路径，从路径终点连接一根线到路径的起点
    [arcPath closePath];
    [arcPath stroke];
    
    //弧2
    UIBezierPath *arcPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(170, 60) radius:25 startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    //添加一根线到圆心
    [arcPath2 addLineToPoint:CGPointMake(170, 60)];
    //关闭路径，从路径终点连接一根线到路径的起点
    [arcPath2 closePath];
    [arcPath2 stroke];
    
    //弧3
    UIBezierPath *arcPath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(225, 60) radius:25 startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    //添加一根线到圆心
    [arcPath3 addLineToPoint:CGPointMake(175, 60)];
    //关闭路径，从路径终点连接一根线到路径的起点
    [arcPath3 closePath];
    [arcPath3 stroke];
    
    //弧4
    UIBezierPath *arcPath4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(280, 60) radius:25 startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    //添加一根线到圆心
    [arcPath4 addLineToPoint:CGPointMake(280, 60)];
    //fill时，会自动关闭路径
    [arcPath4 fill];
}
/**
 饼图
 */
-(void)drawPie{
    //画第一个扇形
    UIBezierPath *arcPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(105, 175) radius:100 startAngle:M_PI endAngle:0 clockwise:YES];
    [[UIColor orangeColor] set];
    [arcPath1 fill];
    
    //画直线，连接扇形终点 - 圆心 - 起点
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    [[UIColor whiteColor] set];
    [linePath1 moveToPoint:CGPointMake(205, 175)];
    //添加一根线到起点
    [linePath1 addLineToPoint:CGPointMake(5, 175)];
    [linePath1 stroke];
    
    //画第二个扇形
    UIBezierPath *arcPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(105, 175) radius:100 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [[UIColor redColor] set];
    //添加一根线到圆心
    [arcPath2 addLineToPoint:CGPointMake(105, 175)];
    [arcPath2 fill];
    
    //画直线，连接扇形终点 - 圆心
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [[UIColor whiteColor] set];
    [linePath2 moveToPoint:CGPointMake(105, 275)];
    //添加一根线到圆心
    [linePath2 addLineToPoint:CGPointMake(105, 175)];
    [linePath2 stroke];
    
    //画第三个扇形
    UIBezierPath *arcPath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(105, 175) radius:100 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [[UIColor blueColor] set];
    //添加一根线到圆心
    [arcPath3 addLineToPoint:CGPointMake(105, 175)];
    [arcPath3 fill];
}
@end
