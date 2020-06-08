//
//  BaseMainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/8.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "BaseMainViewController.h"
#import "SegmenteFirstViewController.h"
#import "SegmenteSecondViewController.h"

@interface BaseMainViewController ()

@property(nonatomic, strong) SegmenteFirstViewController *firstVC;
@property(nonatomic, strong) SegmenteSecondViewController *secondVC;

@property (nonatomic ,strong) UIViewController *currentVC;
@end

@implementation BaseMainViewController
- (SegmenteFirstViewController *)firstVC{
    if(!_firstVC){
        _firstVC = [[SegmenteFirstViewController alloc] init];
    }
    return _firstVC;
}

- (SegmenteSecondViewController *)secondVC{
    if(!_secondVC){
        _secondVC = [[SegmenteSecondViewController alloc] init];
    }
    return _secondVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"电话"]];
    sc.selectedSegmentIndex = 0;
    self.navigationItem.titleView = sc;
    
    [sc addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //将默认的页面添加进去
    [self addChildViewController:self.firstVC];
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}

-(void)goBack{
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

-(void)segmentValueChanged:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
       case 0:
           [self replaceController:self.currentVC newController:self.firstVC];
           break;
       case 1:
           [self replaceController:self.currentVC newController:self.secondVC];
           break;

       default:
           break;
   }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间
     *  options                 动画效果
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    if ([newController isEqual:self.currentVC]) {
        return;
    }
 
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
 
        if (finished) {
 
            [self.view addSubview:newController.view];
            self.currentVC = newController;
 
        }else{
 
            self.currentVC = oldController;
 
        }
    }];
}
 
@end
