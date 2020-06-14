//
//  AnimParticleEffectViewController.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/14.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "AnimParticleEffectViewController.h"
#import "AnimParticleEffectView.h"

@interface AnimParticleEffectViewController ()
@property (strong, nonatomic) IBOutlet AnimParticleEffectView *contentView;


@end

@implementation AnimParticleEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"粒子效果";
    
}
- (IBAction)start:(id)sender {
    [self.contentView start];
}
- (IBAction)redraw:(id)sender {
    [self.contentView redraw];
}
@end
