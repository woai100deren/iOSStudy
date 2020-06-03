//
//  FlagTextField.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "FlagTextField.h"
#import "MJExtension.h"
#import "FlagItem.h"
#import "FlagItemView.h"

@interface FlagTextField() <UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) UIPickerView *pickView;
@end

@implementation FlagTextField

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

- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [FlagItem mj_objectArrayWithFilename:@"flags.plist"];
    }
    return _dataArray;
}

-(void)setUp{
    UIPickerView *pickView = [[UIPickerView alloc]init];
    self.pickView = pickView;
    //修改文本框弹出键盘类型
    self.inputView = self.pickView;
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
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

#pragma mark - clickAction
-(void)okButtonClick:(UIButton *) sender{
    //获取当前选中行
    FlagItem *item = self.dataArray[[self.pickView selectedRowInComponent:0]];
    self.text = item.flagName;
    [self endEditing:YES];
}
-(void)cancelButtonClick:(UIButton *) sender{
    [self endEditing:YES];
}

#pragma mark - UIPickerViewDataSource实现
//总共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//每一列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}


#pragma mark - delegate实现
//每一行的展示内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    FlagItem *item = self.dataArray[row];
    return item.flagName;
}
////每一行展示什么内容，带有属性的字符串（大小、颜色、阴影、描边）
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//}
//每一行展示什么视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    FlagItemView *itemView = [FlagItemView flagItemView];
    FlagItem *item = self.dataArray[row];
    itemView.data = item;
    return itemView;
}
////每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}
//当前选中的是哪一列的哪一行
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    FlagItem *item = self.dataArray[row];
//    self.text = item.flagName;
//}
@end
