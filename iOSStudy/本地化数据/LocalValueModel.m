//
//  LocalValueNSCodingModel.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValueModel.h"

@implementation LocalValueModel
+(instancetype)modelWithName:(NSString*)name andAge:(int)age{
    LocalValueModel *model = [[LocalValueModel alloc]init];
    model.name = name;
    model.age = age;
    return model;
}

//保存对象时，告诉要保存当前对象的哪些属性数据
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
}

//解码方法
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    //当只有遵守了NSCoding协议时，才有[super init]
    if (self = [super init]) {
        if (coder) {
            _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
            _age = [coder decodeIntForKey:@"age"];
        }
    }
    return self;
}

@end
