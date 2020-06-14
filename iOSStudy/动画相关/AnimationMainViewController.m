//
//  AnimationMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimationMainViewController.h"
#import "AnimTransformViewController.h"
#import "AnimCALayerCorrelationViewController.h"
#import "AnimImplicitAnimViewController.h"
#import "AnimClockRotationViewController.h"
#import "AnimCABaseAnimViewController.h"
#import "AnimVolumeVibrateViewController.h"
#import "AnimParticleEffectViewController.h"

@interface AnimationMainViewController ()

@end

@implementation AnimationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动画相关";
}

- (IBAction)jumpTransform:(id)sender {
    [self jump:[[AnimTransformViewController alloc] init]];
}
- (IBAction)calayerCorrelation:(id)sender {
    [self jump:[[AnimCALayerCorrelationViewController alloc] init]];
}
- (IBAction)implicitAnim:(id)sender {
    [self jump:[[AnimImplicitAnimViewController alloc] init]];
}
- (IBAction)clockRotation:(id)sender {
    [self jump:[[AnimClockRotationViewController alloc] init]];
}
- (IBAction)CABaseAnimation:(id)sender {
    [self jump:[[AnimCABaseAnimViewController alloc] init]];
}
- (IBAction)volumeVibrate:(id)sender {
    [self jump:[[AnimVolumeVibrateViewController alloc] init]];
}
- (IBAction)particleEffect:(id)sender {
    [self jump:[[AnimParticleEffectViewController alloc] init]];
}

-(void)jump:(UIViewController*) vc{
    [self.navigationController pushViewController:vc animated:YES];
}
@end
