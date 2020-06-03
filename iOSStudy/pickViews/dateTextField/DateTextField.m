//
//  DateTextField.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DateTextField.h"

@interface DateTextField()
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) UIDatePicker *pickView;
@end

@implementation DateTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    UIDatePicker *pickView = [[UIDatePicker alloc]init];
    self.pickView = pickView;
    //修改UIDatePicker模式
    pickView.datePickerMode = UIDatePickerModeDate;
    //修改时区
    pickView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //修改文本框弹出键盘类型
    self.inputView = self.pickView;
    
    //监听UIDatePicker的数据变化
//    [pickView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    
    UIToolbar *toobar = [[UIToolbar alloc]initWithFrame:CGRectMake( 0, 0,320,  44)];
    toobar.barStyle = UIBarStyleBlackOpaque;
    [toobar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc]init];
    //取消按钮
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] init];
    cancelBtn.title = @"取消";
    cancelBtn.style = UIBarButtonItemStylePlain;
    [cancelBtn setTarget:self];
    [cancelBtn setAction:@selector(cancelButtonClick:)];
    [barItems addObject:cancelBtn];
    
    //中间的弹簧
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *okBtn = [[UIBarButtonItem alloc]init];
    okBtn.title = @"确定";
    okBtn.style = UIBarButtonItemStylePlain;
    [okBtn setTarget:self];
    [okBtn setAction:@selector(okButtonClick:)];
    [barItems addObject:okBtn];
    
    
    //将按钮添加到toobar上
    [toobar setItems:barItems animated:YES];
    toobar.tintColor = UIColor.blackColor;//字颜色
    toobar.barTintColor = UIColor.whiteColor;
    
    self.inputAccessoryView =toobar;
}

#pragma mark - Action
-(void)okButtonClick:(UIButton *) sender{
    //格式化时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.text = [fmt stringFromDate:self.pickView.date];
    [self endEditing:YES];
}
-(void)cancelButtonClick:(UIButton *) sender{
    [self endEditing:YES];
}

//-(void)dateChange:(UIDatePicker *)datePicker{
//    //格式化时间
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    self.text = [fmt stringFromDate:datePicker.date];
//}
@end
