//
//  CarGroup.m
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "CarGroup.h"

@implementation CarGroup

+ (instancetype)carGroupwithDict:(NSDictionary *)dict{
    CarGroup *carGroup = [[self alloc] init];
    carGroup.title = dict[@"title"];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *carDict in dict[@"cars"]) {
        [temp addObject:carDict[@"name"]];
    }
    carGroup.cars = temp;
    return carGroup;
}

@end
