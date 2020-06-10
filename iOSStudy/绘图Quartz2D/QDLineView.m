//
//  DrawView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDLineView.h"

@implementation QDLineView

/**
 专门用来绘图
 */
- (void)drawRect:(CGRect)rect{
    //在drawRect方法中，系统已经帮你创建了一个跟view相关联的上下文(Layer上下文)，直接获取上下文就行了
    //1.获取上下文（获取、创建上下文，都是以uigrahics开头）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.绘制路径
    //画笔
    UIBezierPath *path = [UIBezierPath bezierPath];
    //直线起点、终点
    //把笔移动到xxx点
    [path moveToPoint:CGPointMake(50, 280)];
    //画一条直线直到xxx点
    [path addLineToPoint:CGPointMake(280, 50)];
    //画一条直线直到xxx点
    [path addLineToPoint:CGPointMake(280, 280)];
    //设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    //设置线宽还可以
//    [path setLineWidth:10];
    //设置线与线之间的连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //设置线的顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
//    //设置颜色(此处用的setStroke)，要与第4步匹配。第4步如果用fill，这里就要用fill
//    [[UIColor redColor] setStroke];
    //设置颜色
    //设置颜色(此处用的set)，它会自动去匹配第4步
    [[UIColor redColor] set];
    
    //3.绘制的内容保存到上下文
    //CGPathRef 属于CoreGraphics框架
    CGContextAddPath(ctx, path.CGPath);
    
    //4.把上下文内容渲染到view中(stroke：描边，fill：填充)
    CGContextStrokePath(ctx);
    
    
    //画一条直线还可以采用下面的方式
//    [path moveToPoint:CGPointMake(50, 280)];
//    [path addLineToPoint:CGPointMake(280, 50)];
    //path stroke：底层实际上操作：1、获取上下文  2、描述路径   3、把路径添加到上下文   4、渲染
//    [path stroke];
}

@end
