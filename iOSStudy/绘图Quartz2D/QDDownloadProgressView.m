//
//  QDDownloadProgressView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDDownloadProgressView.h"

@implementation QDDownloadProgressView

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    //手动调用drawRect时，不会创建跟view相关的上下文，所以调用这个方法刷新无效
//    [self drawRect:self.bounds];
    //重绘，系统帮我们调用drawRect，会创建跟view相关的上下文
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGPoint centerPoint = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    //计算要绘制的弧度
    CGFloat endAngle = self.progress * 2 * M_PI - M_PI_2;
    
    
    //弧1：Center：弧所在的圆心，radius半径，startAngle开始角度，endAngle结束角度，clockwise顺时针(YES)还是逆时针(NO)
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:100 startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
    [arcPath stroke];
}
@end
