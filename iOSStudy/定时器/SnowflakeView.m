//
//  SnowflakeView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SnowflakeView.h"

@implementation SnowflakeView
static int _snowY = 0;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(landing) userInfo:nil repeats:YES];
        
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(landing)];
//        //当每一次屏幕刷新时，都会调用这个指定的方法（屏幕每一秒刷新60次）
//        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

-(void)landing{
    _snowY += 10;
    if(_snowY > self.bounds.size.height){
        _snowY = 0;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"snowflake"];
    [image drawAtPoint:CGPointMake(self.bounds.size.width * 0.5, _snowY)];
}

@end
