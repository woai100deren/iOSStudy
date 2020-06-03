//
//  FlagTextField.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "CityTextField.h"
#import "MJExtension.h"
#import "ProvinceModel.h"
#import "CityModel.h"

@interface CityTextField() <UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) UIPickerView *pickView;
@property (nonatomic, assign) long indexOfProvince;//当前默认选中的省份
@end

@implementation CityTextField

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
        _dataArray = [ProvinceModel mj_objectArrayWithFilename:@"ProvincesAndCities.plist"];
    }
    return _dataArray;
}

-(void)setUp{
    UIPickerView *pickView = [[UIPickerView alloc]init];
    self.pickView = pickView;

    self.indexOfProvince = 0;
    
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
    //当前选中的省
    ProvinceModel *provinceModel = self.dataArray[self.indexOfProvince];
    //获取当前选中的市
    CityModel *cityModel = provinceModel.Cities[[self.pickView selectedRowInComponent:1]];

    NSString *provinceName;
    if(self.indexOfProvince == 0 || self.indexOfProvince == 1){
        provinceName = @"";
    }else{
        provinceName = provinceModel.State;
    }
    
    self.text = [NSString stringWithFormat:@"%@%@",provinceName,cityModel.city];
    
    [self endEditing:YES];
}
-(void)cancelButtonClick:(UIButton *) sender{
    [self endEditing:YES];
}

#pragma mark - UIPickerViewDataSource实现
//总共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//每一列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        //获取省的数量
        return self.dataArray.count;
    }else{
        //获取当前省份下的市的数量
        ProvinceModel *provinceModel = self.dataArray[self.indexOfProvince];
        return provinceModel.Cities.count;
    }
}


#pragma mark - delegate实现
//每一行的展示内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        ProvinceModel *provinceModel = self.dataArray[row];
        return provinceModel.State;
    }else{
        ProvinceModel *provinceModel = self.dataArray[self.indexOfProvince];
        CityModel *city = provinceModel.Cities[row];
        return city.city;
    }
}

//当前选中的是哪一列的哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        self.indexOfProvince = row;
        [self.pickView reloadComponent:1];
        [self.pickView selectRow:0 inComponent:1 animated:YES];
    }
}
@end

