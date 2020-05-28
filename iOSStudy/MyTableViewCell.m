//
//  MyTableViewCell.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Masonry.h"

@interface MyTableViewCell()

//这个地方要注意，cell本身自带了imageView的空间，所以这里取名称不能用imageView，否则会出问题
@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *titleView;
@property(nonatomic,weak) UILabel *describeView;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setUpUI{
    //左边图片
    //下面这句不能这么写，因为self.imageView是弱引用，那么[[UIImageView alloc] init]被创造出来就会立马销毁
//    self.imageView =[[UIImageView alloc] init];
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    //赋值要等到控件添加到父控件之后才有效，因为只有添加到父控件之后，iconView指针才是strong
    self.iconView = iconView;
    //添加约束，要等控件添加到父控件之后才有效
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.offset(120);
        make.height.offset(80);
    }];
    
    //右边上面title
    UILabel *titleView = [[UILabel alloc] init];
    [self.contentView addSubview:titleView];
    self.titleView = titleView;
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.top.mas_equalTo(iconView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    //右边下面描述
    UILabel *describeView = [[UILabel alloc] init];
    [self.contentView addSubview:describeView];
    self.describeView = describeView;
    describeView.numberOfLines = 0;
    
    [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleView.mas_left);
        make.top.mas_equalTo(titleView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(iconView.mas_bottom);
        make.right.mas_equalTo(titleView.mas_right);
    }];
    
    
    
}

- (void)setData:(Car *)car{
    self.iconView.image = [UIImage imageNamed:car.image];
    self.titleView.text = car.title;
    self.describeView.text = car.subTitle;
}
@end
