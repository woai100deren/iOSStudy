//
//  ClockRotationViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/12.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimClockRotationViewController.h"

#define perSecAngle 6
#define perMinAngle 6
#define perHourAngle 30

@interface AnimClockRotationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;
@property (weak,nonatomic) CALayer *secLayer;
@property (weak,nonatomic) CALayer *minLayer;
@property (weak,nonatomic) CALayer *hourLayer;
@end

@implementation AnimClockRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"时钟旋转";
    [self addSecNeedle];
    [self addMinutesNeedle];
    [self addHourNeedle];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    [self timeChanged];
}
-(void)timeChanged{
    //获取当前多少秒
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dc = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger curSec = dc.second;
    NSInteger curMin = dc.minute;
    //24小时制
    NSInteger curHour = dc.hour > 11 ? dc.hour - 12 : dc.hour;
    
    CGFloat secAngle = curSec * perSecAngle;
    //分钟的角度，要加上一秒钟所走的角度，一分钟有60秒，所以一秒走6/60 = 0.1角度
    CGFloat minAngle = curMin * perMinAngle + 0.1*curSec;
    //时钟的角度，要加上一分钟所走的角度，一小时有60分钟，所以一分钟走30/60 = 0.5角度
    CGFloat hourAngle = curHour * perHourAngle + 0.5*curMin;
    //绕Z轴旋转
    self.secLayer.transform = CATransform3DMakeRotation(secAngle / 180 * M_PI , 0, 0, 1);
    self.minLayer.transform = CATransform3DMakeRotation(minAngle / 180 * M_PI , 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(hourAngle / 180 * M_PI , 0, 0, 1);
}
/**
 添加秒针
 */
-(void)addSecNeedle{
    CALayer *secLayer = [CALayer layer];
    secLayer.bounds = CGRectMake(0, 0, 1, 110);
    secLayer.backgroundColor = UIColor.redColor.CGColor;
    secLayer.anchorPoint = CGPointMake(0.5, 1);
    secLayer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    [self.clockImageView.layer addSublayer:secLayer];
    self.secLayer = secLayer;
}
/**
 添加分针
 */
-(void)addMinutesNeedle{
    CALayer *minLayer = [CALayer layer];
    minLayer.bounds = CGRectMake(0, 0, 1, 90);
    minLayer.backgroundColor = UIColor.greenColor.CGColor;
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    minLayer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    [self.clockImageView.layer addSublayer:minLayer];
    self.minLayer = minLayer;
}
/**
 添加时针
 */
-(void)addHourNeedle{
    CALayer *hourLayer = [CALayer layer];
    hourLayer.bounds = CGRectMake(0, 0, 1, 70);
    hourLayer.backgroundColor = UIColor.blueColor.CGColor;
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    [self.clockImageView.layer addSublayer:hourLayer];
    self.hourLayer = hourLayer;
}
@end
