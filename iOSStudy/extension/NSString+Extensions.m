//
//  NSString-.m
//  iOSStudy
//
//  Created by 王静 on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

+(BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
