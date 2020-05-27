//
//  MainViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/20.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ScrollViewController.h"
#import "CarView.h"
#import "Car.h"
#import "NewCarView.h"
#import "UIColor+Hex.h"

@interface ScrollViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;
@property (weak, nonatomic) NSTimer *timer;

@end
    

@implementation ScrollViewController
- (void)viewDidLoad{
    [super viewDidLoad];
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = UIColor.redColor;
//    view.frame = CGRectMake(0, 0, 50, 50);
//    [self.scrollView addSubview:view];
    
//    self.scrollView.contentSize = CGSizeMake(500, 500);
    //是否能够滚动,yes能够滚动。设置为NO，滚动不了，但是点击事件有效
    self.scrollView.scrollEnabled = YES;
    //是否能跟用户交互(响应用户的点击等操作)，设置为no，则滚动不了，点击不了。包括里面的子控件，全部都无法点击、交互。
//    self.scrollView.userInteractionEnabled = NO;
    //滚动弹簧效果
    self.scrollView.bounces = YES;
    //主要用在，没有设置contentSize，但是又要滚动，比如下拉刷新，就需要这个设置。
//    self.scrollView.alwaysBounceVertical = YES;
    //是否显示水平  垂直滚动条
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    //scrollView移除控件，这种通过下标的方式去删除不靠谱。
    //如果想靠谱，就需要把showsVerticalScrollIndicator和showsHorizontalScrollIndicator设置为NO
//    [self.scrollView.subviews.firstObject removeFromSuperview];
    
    //内容偏移量（即设置滚动条滚动到哪里）
//    self.scrollView.contentOffset = CGPointMake(10, 10);
    
    //内边距
//    self.scrollView.contentInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    //设置scrollView的代理就是这个控制器
    self.scrollView.delegate = self;
    
    [self addImageView];
}

//点击控制器，会调用这个方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"点击了控制器");
}

-(void)addImageView{
    int count = 4;
    UIImageView *imageView;
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    for (int i=0; i<count; i++) {
        //添加图片
        imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p%d",i+1]];
        imageView.frame = CGRectMake(width * i, 0, width, height);
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    //开启分页功能，滑动不满一页时，会自动滑动到一页或者回退一页
    self.scrollView.pagingEnabled = YES;
    
    //只有1页的时候，要隐藏分页下标点
    //第一种做法
//    if(count <= 1){
//        self.pageView.hidden = YES;
//    }
    //第二种做法，开启单页不显示
    self.pageView.hidesForSinglePage = YES;
    
    self.pageView.numberOfPages = count;
    
    [self startTimer];
}

#pragma mark - timer相关
-(void)startTimer{
    //隔3秒，调用一次nextPage方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)nextPage{
    NSInteger page = self.pageView.currentPage + 1;
    if(page == 4){
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate实现
//当scrollview正在滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll--%f",scrollView.contentOffset.x);
    //只要超过一半，就把页码点移位
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.pageView.currentPage = page;
}

//用户即将开始拖拽scrollview
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging--");
    [self stopTimer];
}

//用户已经停止拖拽scrollview
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate == NO){
        NSLog(@"用户已经停止拖拽，scrollview停止滚动");
    }else{
        NSLog(@"用户已经停止拖拽，但scrollview由于惯性，仍在滚动");
    }
    [self startTimer];
}

//scrollview惯性减速完毕停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //当前页面
    NSLog(@"用户已经停止拖拽，scrollview惯性滚动结束，停止滚动");
}
@end
