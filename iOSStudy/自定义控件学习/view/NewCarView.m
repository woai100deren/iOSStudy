//
//  NewCarView.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/22.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NewCarView.h"
#import "Car.h"
#import "UIColor+Hex.h"

@interface NewCarView()
@property UIImageView *image;
@property UILabel *title;
@property UILabel *subTitle;
@end

@implementation NewCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    [self setUpImageView];
    [self setUpTitleView];
    [self setUpSubTitleView];
}
-(void)setUpImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _image = imageView;
}
-(void)setUpTitleView{
    UILabel *titleView = [[UILabel alloc] init];
    [self addSubview:titleView];
    _title = titleView;
}
-(void)setUpSubTitleView{
    UILabel *subTitleView = [[UILabel alloc] init];
    [self addSubview:subTitleView];
    _subTitle = subTitleView;
    _subTitle.numberOfLines = 0;
    _subTitle.textColor = [UIColor colorWithHexString:@"#C0C0C0"];
}
- (void)layoutSubviews{
    //当前view宽度
    CGFloat viewWidth = self.frame.size.width;
    
    //以下的x、y坐标是基于当前包裹的view的左上角为坐标原点，所以要注意y坐标
    self.image.frame = CGRectMake(10, 7, 100, 70);
    self.title.frame = CGRectMake(120, 7, viewWidth - 10 - 120 , 21);
    self.subTitle.frame = CGRectMake(120, 31, viewWidth - 10 - 120 , 48);
}

- (void)setCar:(Car *)car{
    self.image.image = [UIImage imageNamed:car.image];
    self.title.text = car.title;
    self.subTitle.text = car.subTitle;
}
@end
