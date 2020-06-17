//
//  NSString-.h
//  iOSStudy
//
//  Created by 王静 on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)
+(BOOL)isBlankString:(NSString *)string;
+(NSString *)getFirstLetterFromString:(NSString *)aString;

/**
 非空字符串判断
 nil字符串无法调用方法
 return YES:表示字符串有内容
 return NO:表示为nil或者空白、空格、换行字符串
 */
- (BOOL)isNonEmptyString;
@end
