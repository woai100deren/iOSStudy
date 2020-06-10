//
//  Quartz2DViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/10.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "Quartz2DViewController.h"
#import "Masonry.h"
#import "QDLineView.h"
#import "QDBightView.h"
#import "QDDownloadProgressView.h"
#import "QDShapeView.h"
#import "QDTextView.h"
#import "QDImageView.h"


@interface Quartz2DViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(weak,nonatomic)QDDownloadProgressView *downloadProgressView;
@property(weak,nonatomic)UILabel *downloadProgressLabel;
@end

@implementation Quartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绘图Quartz2D";
}
- (IBAction)drawLine:(id)sender {
    [self drawView:[[QDLineView alloc] init]];
}
- (IBAction)drawBight:(id)sender {
    [self drawView:[[QDBightView alloc] init]];
}
- (IBAction)drawShape:(id)sender {
    [self drawView:[[QDShapeView alloc] init]];
}
- (IBAction)drawDownloadProgress:(id)sender {
    QDDownloadProgressView *view = [[QDDownloadProgressView alloc] init];
    self.downloadProgressView = view;
    [self drawView:view];
    
    UISlider *slider = [[UISlider alloc] init];
    [self.contentView addSubview:slider];
    //view的约束
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(100);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-100);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    
    UILabel *label = [[UILabel alloc] init];
    self.downloadProgressLabel = label;
    label.text = @"0.00%";
    [self.contentView addSubview:label];
    //label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}
- (IBAction)drawText:(id)sender {
    [self drawView:[[QDTextView alloc] init]];
}
- (IBAction)drawImage:(id)sender {
    [self drawView:[[QDImageView alloc] init]];
}

-(void)drawView:(UIView *)view{
    for(UIView *subView in self.contentView.subviews){
        [subView removeFromSuperview];
    }
    view.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:view];
    //view的约束
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
}

-(void)sliderValueChanged:(UISlider *)slider{
    self.downloadProgressLabel.text = [NSString stringWithFormat:@"%0.2f%%",slider.value * 100];
    self.downloadProgressView.progress = slider.value;
}
@end
