//
//  CarGroup.h
//  iOSStudy
//
//  Created by dodoca on 2020/5/27.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CarGroup : NSObject
@property(nonatomic,strong)NSArray *cars;
@property(nonatomic,copy)NSString *title;

+(instancetype)carGroupwithDict:(NSDictionary*) dict;
@end
