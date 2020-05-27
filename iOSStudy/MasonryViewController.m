//
//  ViewController.m
//  iOSPhoneStudy
//
//  Created by 王静 on 2020/5/26.
//  Copyright © 2020 王静. All rights reserved.
//

#import "MasonryViewController.h"
#import "Masonry.h"

@interface MasonryViewController ()
@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:blueView];
  
    //blueView的约束
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.right.mas_equalTo(redView.mas_left).offset(-30);
        make.width.mas_equalTo(redView.mas_width);
        make.height.mas_equalTo(50);
    }];
    
    //redView的约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(blueView.mas_top);
        make.bottom.mas_equalTo(blueView.mas_bottom);
    }];
    
    //mas_makeConstraints是新增约束，修改约束用mas_updateConstraints
    //下面是修改blueView的高度为80
    [blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
    }];
    
    //删除之前所有约束，添加新的约束（慎用）
//    [blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}

-(void)center{
    UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = UIColor.redColor;
        [self.view addSubview:redView];
      
        //1.
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(@100);
    //        make.height.equalTo(@100);
    //        make.centerX.equalTo(self.view.mas_centerX);
    //        make.centerY.equalTo(self.view.mas_centerY);
    //    }];
        
        //2.
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.mas_equalTo(100);//自动包装数据类型
    //        make.height.mas_equalTo(100);
    //        make.centerX.mas_equalTo(self.view.mas_centerX);
    //        make.centerY.mas_equalTo(self.view.mas_centerY);
    //    }];
        //3.
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.mas_equalTo(100);//自动包装数据类型
    //        make.height.mas_equalTo(100);
    //        make.centerX.mas_equalTo(self.view);
    //        make.centerY.mas_equalTo(self.view);
    //    }];
        //4.
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.center.mas_equalTo(self.view);
        }];
}

-(void)edge{
    UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = UIColor.redColor;
        [self.view addSubview:redView];
        
        //1、ios自带约束
    //    redView.translatesAutoresizingMaskIntoConstraints = NO;
    //    NSString *hvfl = @"H:|-[abc(100)]";
    //    NSDictionary *hviews = @{@"abc":redView};
    //    NSArray *hlcs = [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:kNilOptions metrics:nil views:hviews];
    //    [self.view addConstraints:hlcs];
    //
    //    NSString *vvfl = @"V:|-[abc(100)]";
    //    NSDictionary *vviews = @{@"abc":redView};
    //    NSArray *vlcs = [NSLayoutConstraint constraintsWithVisualFormat:vvfl options:kNilOptions metrics:nil views:vviews];
    //    [self.view addConstraints:vlcs];
        
        //2、masonry约束，常规写法（使用最多）
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.view.mas_top).multipliedBy(1.0).offset(20);
    //        make.left.equalTo(self.view.mas_left).multipliedBy(1.0).offset(20);
    //        make.right.equalTo(self.view.mas_right).multipliedBy(1.0).offset(-20);
    //        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(1.0).offset(-20);
    //    }];
        
        //3、masonry约束，简单写法（了解就行）
        //3.1
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.view).multipliedBy(1.0).offset(20);
    //        make.left.equalTo(self.view).multipliedBy(1.0).offset(20);
    //        make.right.equalTo(self.view).multipliedBy(1.0).offset(-20);
    //        make.bottom.equalTo(self.view).multipliedBy(1.0).offset(-20);
    //    }];
        //3.2
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.offset(20);
    //        make.left.offset(20);
    //        make.right.offset(-20);
    //        make.bottom.offset(-20);
    //    }];
    //    //3.3
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.and.left.offset(20);
    //        make.right.and.bottom.offset(-20);
    //    }];
        //3.4
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.offset(20);
    //        make.right.bottom.offset(-20);
    //    }];
        //3.5
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    //    }];
        //3.6
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
}
@end
