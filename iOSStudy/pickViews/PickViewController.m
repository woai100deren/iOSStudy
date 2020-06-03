//
//  PickViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "PickViewController.h"

@interface PickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"PickView示例";
    
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
    [self pickerView:self.pickView didSelectRow:0 inComponent:0];
}

- (NSArray *)dataArray{
    if(!_dataArray){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}

#pragma mark - UIPickerViewDataSource实现
//总共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}
//每一列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *rowArray = self.dataArray[component];
    return rowArray.count;
}


#pragma mark - delegate实现
//每一列的宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//
//}
////每一行的高度
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//
//}
//每一行的展示内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[component][row];
}
////每一行展示什么内容，带有属性的字符串（大小、颜色、阴影、描边）
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//}
////每一行展示什么视图
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//
//}
//当前选中的是哪一列的哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *title = self.dataArray[component][row];
    self.label.text = title;
}
@end
