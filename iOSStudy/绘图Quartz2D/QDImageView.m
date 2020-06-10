//
//  QDImageView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDImageView.h"

@implementation QDImageView

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"nv"];
    
    //图片裁剪，以下给定的区域外的会被自动裁剪掉（设置裁剪区域，要在绘制图片到view之前，否则无效）
    UIRectClip(CGRectMake(0, 0, 300, 400));
    
    //drawAtPoint绘制的是图片原始大小
//    [image drawAtPoint:CGPointZero];
    //drawInRect绘制时，会把当前图片填充到给定的区域中
//    [image drawInRect:rect];
    //drawAsPatternInRect 平铺
    [image drawAsPatternInRect:self.bounds];
}

@end
