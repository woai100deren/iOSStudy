//
//  CarView.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/22.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "CarView.h"
#import "Car.h"

@interface CarView()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (weak,nonatomic) UIToolbar *toolbar;
@end

@implementation CarView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

//唤醒
- (void)awakeFromNib{
    [super awakeFromNib];
    //xib加载中，自定义控件
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [self.image addSubview:toolbar];
    self.toolbar = toolbar;
    self.toolbar.alpha = 0.8;
}

+(instancetype)carView{
    return [[[NSBundle mainBundle] loadNibNamed:@"CarView" owner:nil options:nil] firstObject];
}

-(void)setCar:(Car *) car{
    self.image.image = [UIImage imageNamed:car.image];
    self.title.text = car.title;
    self.subTitle.text = car.subTitle;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //获取自身的尺寸
//    CGFloat width = self.frame.size.width;
//    CGFloat height = self.frame.size.height;
    
    self.toolbar.frame = self.image.bounds;
}

@end
