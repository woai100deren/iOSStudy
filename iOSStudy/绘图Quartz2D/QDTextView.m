//
//  QDTextView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "QDTextView.h"

@implementation QDTextView


- (void)drawRect:(CGRect)rect {
    NSString *text = @"长得很俊俏！长得很俊俏！长得很俊俏！长得很俊俏！";
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    //字体大小
    attrDic[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    //字体颜色
    attrDic[NSForegroundColorAttributeName] = [UIColor redColor];
    //设置描边颜色
    attrDic[NSStrokeColorAttributeName] = [UIColor greenColor];
    //设置描边宽度
    attrDic[NSStrokeWidthAttributeName] = @2;
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColor.blueColor;
    //阴影偏移量
    shadow.shadowOffset = CGSizeMake(5, 5);
    shadow.shadowBlurRadius = 2;
    attrDic[NSShadowAttributeName] = shadow;
    
    //用drawAtPoint不会自动换行
//    [text drawAtPoint:CGPointZero withAttributes:attrDic];
    //用drawInRect会自动换行
    [text drawInRect:rect withAttributes:attrDic];
}

@end
