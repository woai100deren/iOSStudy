//
//  ProvinceModel.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

//模型里面包含数组，数组又包含模型时，需要如下做描述，否则转换时转换不了
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"Cities" : @"CityModel"};//前边，是属性数组的名字，后边就是类名
}
@end
