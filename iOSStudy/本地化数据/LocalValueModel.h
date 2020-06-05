//
//  LocalValueNSCodingModel.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/5.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalValueModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)int age;

+(instancetype)modelWithName:(NSString*)name andAge:(int)age;
@end

NS_ASSUME_NONNULL_END
