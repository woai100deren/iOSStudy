//
//  DBImageDealView.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DBImageDealView.h"

@interface DBImageDealView()<UIGestureRecognizerDelegate>
@property(nonatomic,weak)UIImageView *imageView;
@end
@implementation DBImageDealView
- (UIImageView *)imageView{
    if(_imageView == nil){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.bounds;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _imageView = imageView;
        
        [self addGes];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}
-(void)addGes{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGes.delegate = self;
    [self.imageView addGestureRecognizer:panGes];
    
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotationGes.delegate = self;
    [self.imageView addGestureRecognizer:rotationGes];

    UIPinchGestureRecognizer *pinGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pin:)];
    pinGes.delegate = self;
    [self.imageView addGestureRecognizer:pinGes];

    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(long:)];
    longGes.delegate = self;
    [self.imageView addGestureRecognizer:longGes];
}
/**
 拖拽手势
 */
-(void)pan:(UIPanGestureRecognizer *)panGes{
    CGPoint point = [panGes translationInView:panGes.view];
    panGes.view.transform = CGAffineTransformTranslate(panGes.view.transform, point.x, point.y);
    [panGes setTranslation:CGPointZero inView:panGes.view];
}

/**
 捏合手势
 */
-(void)pin:(UIPinchGestureRecognizer *)pinGes{
    pinGes.view.transform = CGAffineTransformScale(pinGes.view.transform, pinGes.scale, pinGes.scale);
    //复位
    [pinGes setScale:1];
}
/**
 旋转手势
 */
-(void)rotation:(UIRotationGestureRecognizer *)rotationGes{
    rotationGes.view.transform = CGAffineTransformRotate(rotationGes.view.transform, rotationGes.rotation);
    //复位
    rotationGes.rotation = 0;
}

/**
 长按手势
 */
-(void)long:(UILongPressGestureRecognizer *)longGes{
    if(longGes.state == UIGestureRecognizerStateBegan){
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.imageView.alpha = 1;
            }completion:^(BOOL finished) {
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                //关闭上下文
                UIGraphicsEndImageContext();
                //调用代理方法
                [self.delegate dbImageDealView:self newImage:newImage];

                [self removeFromSuperview];
            }];
        }];
    }
}
/**
 支持同时多手势
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end
